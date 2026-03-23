import QtQuick
import QtQuick.Layouts
import Quickshell

Item {
    id: root

    property string componentFontFace: "monospace"
    property int componentFontSize: 24

    property color componentTextColor: "white"
    property color componentBGColor: "black"

    property double componentCornerRadius: 2

    implicitWidth: layout.implicitWidth * 1.25
    implicitHeight: layout.implicitHeight * 1.4

    Rectangle {
        anchors.fill: parent

        color: root.componentBGColor
        radius: root.componentCornerRadius

        opacity: 0.75
    }

    ColumnLayout {
        id: layout

        anchors.centerIn: parent

        spacing: 0

        SystemClock {
            id: clock
            property string timeFormated: Qt.formatDateTime(date, "hh:mm:ss AP")
            property string dateFormated: Qt.formatDateTime(date, "MMMM d, yyyy")
        }

        Text {
            id: timeDisplay
            text: clock.timeFormated

            Layout.alignment: Qt.AlignCenter

            font.family: root.componentFontFace
            font.pixelSize: root.componentFontSize
            color: root.componentTextColor
        }

        Text {
            id: dateDisplay
            text: clock.dateFormated

            Layout.alignment: Qt.AlignCenter

            font.family: root.componentFontFace
            font.pixelSize: root.componentFontSize / 2
            color: root.componentTextColor
        }
    }
}
