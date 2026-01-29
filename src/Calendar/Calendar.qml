pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Io

Rectangle {
    id: renderRoot

    property string fontFace
    property var fontSize

    width: parent.width
    height: parent.height

    color: "transparent"

    Process {
        id: dateProcess

        property string dateToday: "Jan. 1, 1970"

        running: true
        command: ["date", '+%b. %d, %Y']

        stdout: StdioCollector {
            onStreamFinished: () => {
                dateOutput.text = this.text;
            }
        }
    }

    Process {
        id: calendarProcess

        running: true
        command: ["cal"]

        property string calendarOut: "Um..."

        onRunningChanged: () => {
            if (!calendarProcess.running) {
                calendarProcess.running = true;
            }
        }

        stdout: StdioCollector {
            onStreamFinished: () => {
                calendarOutput.text = this.text;
            }
        }
    }

    ColumnLayout {
        width: renderRoot.width
        height: renderRoot.height

        spacing: -25

        anchors.centerIn: parent

        Text {
            id: calendarOutput

            textFormat: Text.PlainText
            wrapMode: Text.NoWrap

            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter

            Layout.alignment: Qt.AlignHCenter

            color: "#FFFFFF"

            font {
                family: renderRoot.fontFace || "monospace"
                weight: 750
                pointSize: renderRoot.fontSize || 10
            }
        }

        Text {
            id: dateOutput

            color: "#FFFFFF"

            Layout.alignment: Qt.AlignHCenter

            font {
                family: renderRoot.fontFace || "monospace"
                weight: 750
                pointSize: renderRoot.fontSize || 10
            }
        }
    }
}
