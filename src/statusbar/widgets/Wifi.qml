import QtQuick

import Quickshell.Io

Rectangle {
    id: bar_base

    property string fontFamily: "monospace"

    property string idleColor: "transparent"
    property string hoverColor

    color: "transparent"

    implicitWidth: label.implicitWidth * 1.5

    Process {
        id: wifiMenuProcess

        running: false
        command: ["kitty", "impala"]
    }

    Text {
        id: label

        text: "Internet"

        anchors.centerIn: parent

        font.family: bar_base.fontFamily
        font.pixelSize: bar_base.height * 0.75

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
            wifiMenuProcess.running = true;
        }
    }
}
