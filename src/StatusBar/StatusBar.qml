import QtQuick
import Quickshell

PanelWindow {
    Hyprland {
        width: parent.width * 0.3
        height: parent.height

        layoutRadius: 10
        layoutMargin: 2

        focusedWidth: 25
        focusedHeight: 12
        diameter: 8

        color: "#B2000000"

        anchors {
            left: parent.left
            leftMargin: 10
            top: parent.top
            topMargin: 3
            verticalCenter: parent.verticalCenter
        }
    }

    Clock {
        anchors.centerIn: parent

        width: 165
        height: parent.height

        radius: 10

        color: "#020f24"
    }
}
