import QtQuick

import "./../mpris" as MPRIS

Text {
    id: root

    property int currentLine: 0

    MPRIS.Wrapper {
        id: controller
    }

    API {
        id: lyricsAPI

        artist: controller.trackedPlayer.trackArtist
        title: controller.trackedPlayer.trackTitle
    }

    Connections {
        id: controllerEvents
        target: controller

        function onTrackedPlayerPositionChanged() {
            if (!lyricsAPI.lyricsExist || !lyricsAPI.lyricsLines)
                return;

            const pos = controller.trackedPlayerPosition;

            let activeLine = "";

            for (let i = 0; i < lyricsAPI.lyricsLines.length; i++) {
                const line = lyricsAPI.lyricsLines[i];
                const time = lyricsAPI.lrcToSeconds(line);

                if (pos >= time) {
                    activeLine = line;
                } else {
                    break;
                }
            }

            root.text = lyricsAPI.stripLRCTimestamp(activeLine).toUpperCase();
        }
    }
}
