import QtQuick

import Quickshell.Io

Rectangle {
    id: bar_base

    property string fontFamily: "monospace"

    property string idleColor: "transparent"
    property string hoverColor

    color: "transparent"

    Process {
        id: notifMenuProcess

        running: false
        command: ["swaync-client", "-R", "-Rs", "-t"]
    }

    Text {
        text: "Notifications"

        anchors.centerIn: parent

        font.family: bar_base.fontFamily
        font.pixelSize: bar_base.height * 0.8

        color: "white"
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: true

        onEntered: {
            bar_base.color = bar_base.hoverColor;
        }

        onExited: {
            bar_base.color = bar_base.idleColor;
        }

        onClicked: {
            notifMenuProcess.running = true;
        }
    }
}
