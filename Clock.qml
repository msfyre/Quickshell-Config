import QtQuick
import QtQuick.Layouts
import Quickshell

ColumnLayout {
    id: root

    property string componentFontFace: "monospace"
    property int componentFontSize: 24
    property color componentFontColor: "white"

    spacing: 0

    SystemClock {
        id: clock
        property string timeFormated: Qt.formatDateTime(date, "hh:mm:ss AP")
        property string dateFormated: Qt.formatDateTime(date, "MMMM d, yyyy")
    }

    Text {
        id: timeDisplay
        text: clock.timeFormated

        Layout.alignment: Qt.AlignRight

        font.family: root.componentFontFace
        font.pixelSize: root.componentFontSize
        color: root.componentFontColor
    }

    Text {
        id: dateDisplay
        text: clock.dateFormated

        Layout.alignment: Qt.AlignRight

        font.family: root.componentFontFace
        font.pixelSize: root.componentFontSize / 2
        color: root.componentFontColor
    }
}
