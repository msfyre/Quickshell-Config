import QtQuick
import QtQuick.Layouts
import Quickshell

import "./widgets/" as StatusBarWidgets
import "./widgets/hyprland/" as HyprlandBar

PanelWindow {
    id: base

    property string baseColor: "black"

    property string elementIdleColor: "transparent"
    property string elementHoverColor: "transparent"

    property double elementRadius
    property double elementHeight: 12
    property double elementMargins: elementRadius

    property string elementFontFamily: "monospace"
    property double elementFontPixelSize: 10
    property string elementTextColor: "white"

    implicitWidth: Screen.width
    implicitHeight: 0

    anchors.top: true

    color: "transparent"

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 250
        }
    }

    RowLayout {
        id: statusRow

        anchors.fill: parent

        spacing: 5

        Rectangle {
            id: left

            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.leftMargin: statusRow.spacing * 2

            color: base.baseColor

            bottomLeftRadius: base.elementRadius
            bottomRightRadius: base.elementRadius

            Behavior on color {
                ColorAnimation {
                    duration: 1000
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: base.elementMargins

                Layout.alignment: Qt.AlignVCenter

                StatusBarWidgets.User {
                    implicitHeight: base.elementHeight

                    radius: base.elementRadius

                    fontFamily: base.elementFontFamily
                    fontPixelSize: base.elementFontPixelSize
                }

                HyprlandBar.Base {
                    Layout.fillWidth: true

                    implicitHeight: base.elementHeight

                    idleColor: base.elementIdleColor
                    hoverColor: base.elementHoverColor

                    idleWidthMult: 0.05
                    focusedWidthMult: 0.2
                    hoveredWidthMult: 0.25

                    indicatorDiameter: 7.5

                    radius: base.elementRadius

                    fontFamily: base.elementFontFamily
                    fontPixelSize: base.elementFontPixelSize
                }
            }
        }

        Rectangle {
            id: center

            implicitWidth: 250
            implicitHeight: base.height

            color: base.baseColor
            bottomLeftRadius: base.elementRadius
            bottomRightRadius: base.elementRadius

            Behavior on color {
                ColorAnimation {
                    duration: 1000
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: base.elementMargins

                Layout.alignment: Qt.AlignVCenter

                StatusBarWidgets.Clock {
                    Layout.fillWidth: true
                    implicitHeight: base.elementHeight

                    fontFamily: base.elementFontFamily
                    fontPixelSize: base.elementFontPixelSize
                }
            }
        }

        Rectangle {
            id: right

            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.rightMargin: statusRow.spacing * 2

            color: base.baseColor

            bottomLeftRadius: base.elementRadius
            bottomRightRadius: base.elementRadius

            Behavior on color {
                ColorAnimation {
                    duration: 1000
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: base.elementMargins

                Layout.alignment: Qt.AlignRight

                spacing: 0
            }
        }
    }
}
