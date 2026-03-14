import QtQuick

import Quickshell.Io

Rectangle {
    id: bar_base

    property string fontFamily: "monospace"
    property double fontPixelSize: 10

    property string idleColor: "transparent"
    property string hoverColor

    color: idleColor

    implicitWidth: label.implicitWidth * 2

    Process {
        id: notifMenuProcess

        running: false
        command: ["swaync-client", "-R", "-Rs", "-t"]
    }

    Text {
        id: label

        text: ""

        anchors.centerIn: parent

        font.family: bar_base.fontFamily
        font.pixelSize: bar_base.fontPixelSize

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
