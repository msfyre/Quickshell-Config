pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import "./src/StatusBar"
import "./src/Calendar"
import "./src/MusicPlayer/"

Singleton {
    id: root

    StatusBar {
        id: statusbar

        anchors {
            top: true
        }

        color: "transparent"

        implicitWidth: Screen.width
        implicitHeight: 30

        layoutRadius: 5
    }

    Calendar {
        anchors {
            left: true
            bottom: true
        }

        aboveWindows: false

        width: msx_player.renderedWidth
        implicitHeight: 200

        color: "#A0020F24"
        fontFace: "JetBrainsMono Nerd Font"
        pixelFontSize: 10
    }

    MusicPlayer {
        id: msx_player

        anchors {
            bottom: true
        }

        width: Screen.width
        height: 25

        buttonColor: "#020f24"
        buttonRadius: 50

        buttonFontFamily: "JetBrainsMono Nerd Font"
        buttonTextSize: 10

        color: "transparent"
    }

    // TODO: Make this functional
    /*VolumeIndicatorPanel {
        implicitWidth: 250
        implicitHeight: 40

        x_pos: 50
        y_pos: 25
        }*/
}
