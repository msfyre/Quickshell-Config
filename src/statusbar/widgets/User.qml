import QtQuick
import Quickshell.Io

Rectangle {
    id: bar_base

    implicitWidth: displayText.implicitWidth * 1.5

    anchors {
        verticalCenter: parent.verticalCenter
    }

    color: "#A0000000"

    property string fontFamily: "monospace"
    property double fontPixelSize: 10

    property string username: "linus-torvalds"
    property string hostname: "linux"

    Process {
        command: ["whoami"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                bar_base.username = this.text.trim();
            }
        }
    }

    Process {
        command: ["cat", "/etc/hostname"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                bar_base.hostname = this.text.trim();
            }
        }
    }

    Text {
        id: displayText

        anchors.centerIn: parent

        text: bar_base.username + "@" + bar_base.hostname

        color: "white"

        font.family: bar_base.fontFamily
        font.pixelSize: bar_base.fontPixelSize * 0.9

        font.weight: 600
    }

    Component.onCompleted: {
        implicitHeight *= 3 / 2;
        radius /= Math.E;
    }
}
