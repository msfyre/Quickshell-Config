import QtQuick
import Quickshell.Io

Rectangle {
    id: root_current_msx_playing

    property string fontFamily
    property double pixelFontSize

    width: playing_text.implicitWidth + (playing_text.anchors.leftMargin + playing_text.anchors.rightMargin)
    height: parent.height

    Behavior on width {
        NumberAnimation {
            duration: text_opacity_animation.duration / 5
        }
    }

    Process {
        id: mpd_playing

        property string track
        property bool isPlaying

        running: true
        command: ["mpc", "current"]

        stdout: StdioCollector {
            onStreamFinished: () => {
                mpd_playing.isPlaying = this.text != "";
                mpd_playing.track = this.text;
            }
        }

        onRunningChanged: () => {
            running = true;
        }
    }

    Text {
        id: playing_text

        wrapMode: Text.NoWrap

        text: mpd_playing.track || "Nothing is playing right now..."

        anchors {
            fill: parent
            margins: 10
        }

        font.family: root_current_msx_playing.fontFamily
        font.pixelSize: Math.min(root_current_msx_playing.height, root_current_msx_playing.pixelFontSize)

        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter

        color: "white"

        Behavior on text {
            PropertyAnimation {
                id: text_opacity_animation

                target: playing_text
                property: "opacity"

                from: 0
                to: 1

                duration: 500
            }
        }
    }
}
