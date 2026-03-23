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

    readonly property double barRadius: height / 8
    property string barColor: "red"

    property string elementColor: "white"
    property string elementFontFace: "monospace"
    property double elementFontSize: 10

    anchors {
        left: true
        right: true
    }

    color: "transparent"

    Behavior on barColor {
        ColorAnimation {
            duration: 500
        }
    }

    Item {
        id: bar

        anchors {
            fill: parent
        }

        Rectangle {
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
            }

            implicitWidth: left.width + left.anchors.leftMargin
            implicitHeight: left.height
            color: root.barColor

            topRightRadius: root.barRadius
            bottomRightRadius: root.barRadius

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

            topLeftRadius: root.barRadius
            bottomLeftRadius: root.barRadius

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

                selectorBackgroundColor: root.barColor
            }

            Music {
                color: root.elementColor
                font.family: root.elementFontFace
                font.pixelSize: root.elementFontSize * 1.1
            }
        }
    }
}
