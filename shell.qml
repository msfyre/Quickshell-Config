pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import "./src/StatusBar"
import "./src/Calendar"
import "./src/MusicPlayer/"
import "./src/Volume/"

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

    PanelWindow {
        anchors {
            left: true
            bottom: true
        }

        aboveWindows: false

        implicitWidth: 300
        implicitHeight: 200

        color: "#A0020F24"

        Calendar {
            fontFace: "JetBrainsMono Nerd Font"
            fontSize: 7.5
        }
    }

    MusicPlayer {
        anchors {
            right: true
            bottom: true
        }

        aboveWindows: false

        width: Screen.width
        height: 25

        windowRadius: 5

        buttonColor: "#020f24"
        buttonRadius: 50

        buttonFontFamily: "JetBrainsMono Nerd Font"
        buttonTextSize: 12

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
