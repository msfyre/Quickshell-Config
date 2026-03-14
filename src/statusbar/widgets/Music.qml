import QtQuick
import Quickshell.Io

Rectangle {
    id: bar_base

    property string currentlyPlaying: "Nothing..."

    required property string alignment

    property double textMargins: 0
    property string fontFamily
    property double fontPixelSize: 10

    anchors.verticalCenter: parent.verticalCenter

    Process {
        id: mpcCurrent

        command: ["mpc", "current"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                if (this.text.length > 0) {
                    bar_base.currentlyPlaying = this.text.trim().toUpperCase();
                } else {
                    bar_base.currentlyPlaying = "Nothing...";
                }
            }
        }
    }

    Text {
        id: displayText

        text: bar_base.currentlyPlaying

        anchors.verticalCenter: parent.verticalCenter

        color: "white"

        font.family: bar_base.fontFamily
        font.pixelSize: bar_base.fontPixelSize

        Behavior on text {
            PropertyAnimation {
                property: "opacity"
                target: displayText
                from: 0
                to: 1

                duration: 1000
            }
        }

        function alignLeft() {
            anchors.left = bar_base.left;
            anchors.leftMargin = bar_base.fontPixelSize / 2;

            anchors.right = null;
        }
        function alignCenter() {
            anchors.centerIn = bar_base;
        }
        function alignRight() {
            anchors.right = bar_base.right;
            anchors.rightMargin = bar_base.fontPixelSize / 2;

            anchors.left = null;
        }

        Component.onCompleted: {
            const alignmentUppercase = bar_base.alignment.toUpperCase();

            if (alignmentUppercase == "LEFT")
                alignLeft();
            else if (alignmentUppercase == "CENTER")
                alignCenter();
            else if (alignmentUppercase == "RIGHT")
                alignRight();
            else
                alignLeft();
        }
    }

    Timer {
        interval: 250

        running: true
        repeat: true

        onTriggered: {
            mpcCurrent.running = true;
        }
    }
}
