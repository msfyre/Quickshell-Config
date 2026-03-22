import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "."

PanelWindow {
    id: root

    property var modelData
    // TODO: Make Tooltip object

    WlrLayershell.namespace: "shell:bar"

    property string barColor: "red"

    property string elementColor: "white"
    property string elementFontFace: "monospace"
    property double elementFontSize: 10

    anchors {
        top: true
        left: true
        right: true
    }

    color: "transparent"

    Item {
        id: bar

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        implicitHeight: root.height

        Rectangle {
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
            }

            implicitWidth: left.width + left.anchors.leftMargin
            implicitHeight: left.height
            color: root.barColor

            topRightRadius: height / 8
            bottomRightRadius: height / 8

            Behavior on implicitWidth {
                NumberAnimation {
                    easing.type: Easing.OutQuart
                    duration: 200
                }
            }
        }

        Rectangle {
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
            }

            implicitWidth: right.width + right.anchors.rightMargin + right.anchors.leftMargin
            implicitHeight: right.height

            color: root.barColor

            topLeftRadius: height / 8
            bottomLeftRadius: height / 8

            Behavior on implicitWidth {
                NumberAnimation {
                    easing.type: Easing.OutQuart
                    duration: 200
                }
            }
        }

        RowLayout {
            id: left

            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                leftMargin: 10
                rightMargin: 10
            }

            spacing: 10

            Workspaces {
                elementColor: root.elementColor
                elementHeight: root.elementFontSize
                elementFontFace: root.elementFontFace
            }
        }

        RowLayout {
            id: right

            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
                leftMargin: 10
                rightMargin: 10
            }

            spacing: 10

            Wallpaper {
                fontFace: root.elementFontFace
                fontSize: root.elementFontSize * 1.1
                fontColor: root.elementColor
            }

            Music {
                color: root.elementColor
                font.family: root.elementFontFace
                font.pixelSize: root.elementFontSize * 1.1
            }
        }
    }
}
