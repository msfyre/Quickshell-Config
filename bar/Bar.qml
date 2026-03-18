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

    property string leftColor: "red"

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
            implicitWidth: left.width + left.anchors.leftMargin + left.anchors.rightMargin
            implicitHeight: left.height
            color: root.leftColor

            topRightRadius: width / 24
            bottomRightRadius: width / 24

            Behavior on implicitWidth {
                NumberAnimation {
                    easing.type: Easing.OutBack
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
                leftMargin: 5
                rightMargin: 5
            }

            spacing: 10

            Monitor {
                font.family: root.elementFontFace
                font.pixelSize: root.elementFontSize

                color: "white"
            }

            Workspaces {
                monitorIndicatorFontFace: root.elementFontFace
                monitorIndicatorFontSize: root.elementFontSize
            }
        }
    }
}
