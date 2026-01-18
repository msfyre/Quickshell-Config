import QtQuick
import Quickshell
import "src/StatusBar"

PanelWindow {
    anchors {
        top: true
    }

    color: "transparent"

    implicitWidth: Screen.width
    implicitHeight: 24

    StatusBar {}
}
