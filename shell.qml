pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import "./src/StatusBar"
import "./src/Calendar"

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
    }

    PanelWindow {
        anchors {
            left: true
            bottom: true
        }

        aboveWindows: false

        implicitWidth: 275
        implicitHeight: 200

        color: "#A0020F24"

        Calendar {
            fontFace: "JetBrainsMono Nerd Font"
            fontSize: 8
        }
    }
}
