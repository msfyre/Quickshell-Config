import QtQuick
import Quickshell

Item {
    id: base

    property string textColor: "white"

    property string fontFamily: "monospace"
    property double fontPixelSize: 10

    SystemClock {
        id: clock

        property string timeFormatted: Qt.formatDateTime(clock.date, "hh:mm:ss AP")
        property string dateFormatted: Qt.formatDateTime(clock.date, "MM/dd/yyyy")
    }

    Column {
        anchors.centerIn: parent

        spacing: 0

        Text {
            id: timeDisplay

            text: clock.timeFormatted
            color: base.textColor

            anchors.horizontalCenter: parent.horizontalCenter

            font.family: base.fontFamily
            font.pixelSize: base.fontPixelSize
        }

        Text {
            id: dateDisplay

            text: clock.dateFormatted
            color: base.textColor

            anchors.horizontalCenter: parent.horizontalCenter

            font.family: base.fontFamily
            font.pixelSize: base.fontPixelSize / (Math.PI / 2)
        }
    }
}
