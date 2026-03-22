import QtQuick
import QtQuick.Layouts

import "./../wallpaper" as Wallpaper

Item {
    id: root

    implicitWidth: display_text.implicitWidth * 1.05
    implicitHeight: fontSize * 1.1

    property string fontFace: "monospace"
    property color fontColor: "white"
    property double fontSize: 10

    Wallpaper.Window {
        id: switcher

        elementFontFace: root.fontFace
        elementFontSize: root.fontSize
        elementTextColor: root.fontColor
    }

    MouseArea {
        id: mouse_area
        hoverEnabled: true

        Layout.alignment: Qt.AlignLeft

        implicitWidth: parent.width
        implicitHeight: parent.height * 1.2

        Rectangle {
            anchors.fill: parent
            color: "black"
            opacity: mouse_area.containsMouse ? 0.2 : 0
        }

        onClicked: {
            switcher.visible = true;
        }
    }

    Text {
        id: display_text
        anchors.centerIn: parent

        text: "Wallpaper Selector"
        color: root.fontColor

        font.family: root.fontFace
        font.pixelSize: root.fontSize
    }
}
