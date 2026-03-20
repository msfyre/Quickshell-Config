pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.Mpris

import "./../mpris/" as Mpris

// BUGS THAT I HAVE ENCOUNTERED:
// * Right lyrics, wrong time
//      - This bug occurs when the song currently playing is skipped by using 'mpc next' on the command line (it may happen sometimes)

Item {
    id: root

    property MprisPlayer mpdPlayer: Mpris.Fetcher.getPlayerByIdentity("mpd")
    property int maximumLinesVisible: 1
    property var visibleLines: []
    property int currentLineIdx: 0

    property string componentFontFace: "monospace"
    property double componentFontSize: 10
    property color componentColor: "white"

    Column {
        anchors {
            left: parent.left
            bottom: parent.bottom
        }

        Repeater {
            model: root.visibleLines

            Text {
                required property var modelData

                text: modelData.line

                color: root.componentColor
                font.family: root.componentFontFace
                font.pixelSize: Math.max(root.componentFontSize * 0.8, root.componentFontSize * (multiplier * (Math.E / 2)))

                property real multiplier: 1 - Math.abs((modelData.line_index - (root.currentLineIdx - 1)) / root.maximumLinesVisible)

                opacity: multiplier
            }
        }
    }

    API {
        id: lyricsAPI

        artist: root.mpdPlayer.trackArtist
        title: root.mpdPlayer.trackTitle
    }

    Connections {
        target: root.mpdPlayer

        function onTrackChanged() {
            root.visibleLines = [
                {
                    line_index: 0,
                    line: "..."
                }
            ];
        }

        function onPositionChanged() {
            if ((!lyricsAPI.lyricsExist || !lyricsAPI.lyricsLines) && (lyricsAPI.fetchStatus == 404)) {
                root.visibleLines = [
                    {
                        line_index: 0,
                        line: "No lyrics found."
                    }
                ];
                return;
            }

            const position = root.mpdPlayer.position;

            let newLines = [
                {
                    line_index: 0,
                    line: "..."
                }
            ];

            for (let lineidx = 0; lineidx < lyricsAPI.lyricsLines.length; lineidx++) {
                root.currentLineIdx = lineidx;

                const currentline = lyricsAPI.lyricsLines[lineidx];
                const time = lyricsAPI.lrcToSeconds(currentline);

                if (position <= time) {
                    for (let delta = 0; delta < root.maximumLinesVisible; delta++) {
                        const lineidx_withDelta = lineidx - (root.maximumLinesVisible - delta);
                        const line = lyricsAPI.lyricsLines[lineidx_withDelta];

                        if (!line)
                            continue;

                        const stripped = lyricsAPI.stripLRCTimestamp(line);
                        const data = {
                            line_index: lineidx_withDelta,
                            line: stripped.length > 0 ? stripped : "..."
                        };

                        newLines.push(data);
                    }

                    break;
                }
            }

            root.visibleLines = newLines;
        }
    }

    FrameAnimation {
        running: root.mpdPlayer.isPlaying
        onTriggered: root.mpdPlayer.positionChanged()
    }
}
