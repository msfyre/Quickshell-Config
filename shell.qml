import QtQuick
import Quickshell

import "./src/StatusBar"
import "./src/Notifications"

StatusBar {
    id: statusbar

    anchors {
        top: true
    }

    color: "#AB101080"

    implicitWidth: Screen.width
    implicitHeight: 25
}
