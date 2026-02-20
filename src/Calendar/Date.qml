pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

PanelWindow {
    id: root_calendar

    property string fontFace
    property double pixelFontSize

    implicitHeight: dateOutput.implicitHeight * 1.5

    aboveWindows: false

    Rectangle {
        id: renderRoot

        width: parent.width
        height: parent.height

        radius: 5

        color: "transparent"

        Process {
            id: date

            property string dateToday: "Jan. 1, 1970"

            running: true
            command: ["date", "+|> %B %d, %Y <|"]

            stdout: StdioCollector {
                onStreamFinished: () => {
                    dateOutput.text = this.text.trim();
                }
            }
        }

        Text {
            id: dateOutput

            color: "#FFFFFF"

            anchors.centerIn: parent

            font {
                family: root_calendar.fontFace || "monospace"
                weight: 750
                pixelSize: root_calendar.pixelFontSize
            }
        }
    }
}
