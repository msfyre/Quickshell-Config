import QtQuick
import Quickshell

Rectangle {
    id: bar_base

    property string fontFamily: "monospace"

    color: "transparent"

    SystemClock {
        id: clock

        property string timeFormat: Qt.formatTime(date, "hh:mm:ss A")
        property string dateFormat: Qt.formatDate(date, "MM/dd/yyyy")
    }

    Text {
        id: output

        property bool isShowingDate: false

        anchors.centerIn: parent

        color: "white"

        font {
            family: bar_base.fontFamily
            pixelSize: bar_base.height
        }

        text: isShowingDate ? clock.dateFormat : clock.timeFormat
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: true

        onEntered: {
            output.isShowingDate = true;
            output.text = clock.dateFormat;
        }

        onExited: {
            output.isShowingDate = false;
            output.text = clock.timeFormat;
        }
    }

    Timer {
        interval: 0
        running: true
        repeat: true

        onTriggered: {
            output.text = output.isShowingDate ? Qt.formatDate(clock.date, "MM/dd/yyyy") : Qt.formatTime(clock.date, "hh:mm:ss A");
        }
    }
}
