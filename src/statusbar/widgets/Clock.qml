import QtQuick
import QtQuick.Layouts
import Quickshell

Item {
    id: bar_base

    property string fontFamily: "monospace"
    property double fontPixelSize: 10

    readonly property string timeFormatString: "<| hh | mm | ss | A |>"
    readonly property string dateFormatString: "<| MM | dd | yyyy |>"

    Layout.alignment: Qt.AlignVCenter

    SystemClock {
        id: clock

        property string timeFormat: Qt.formatTime(date, bar_base.timeFormatString)
        property string dateFormat: Qt.formatDate(date, bar_base.dateFormatString)
    }

    Text {
        id: output

        property bool isShowingDate: false

        anchors.centerIn: parent

        color: "white"

        font {
            family: bar_base.fontFamily
            pixelSize: bar_base.fontPixelSize
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
        interval: 200
        running: true
        repeat: true

        onTriggered: {
            output.text = output.isShowingDate ? Qt.formatDate(clock.date, bar_base.dateFormatString) : Qt.formatTime(clock.date, bar_base.timeFormatString);
        }
    }
}
