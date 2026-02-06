import QtQuick
import Quickshell

PanelWindow {
    Hyprland {
        width: parent.width * 0.3
        height: parent.height

        layoutRadius: 5

        focusedWidth: 25
        focusedHeight: 12
        diameter: 8

        color: "#020f24"

        anchors {
            left: parent.left
            leftMargin: 10
            top: parent.top
            topMargin: 5
            verticalCenter: parent.verticalCenter
        }
    }

    Clock {
        width: 165
        height: parent.height

        radius: 5

        anchors {
            top: parent.top
            topMargin: 2
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        color: "#020F24"
    }

    Hardware {
        width: parent.width * 0.1
        height: parent.height

        color: "transparent"

        anchors {
            right: parent.right
            rightMargin: 10
            top: parent.top
            topMargin: 5
            verticalCenter: parent.verticalCenter
        }

        buttonRadius: 5
    }
}
