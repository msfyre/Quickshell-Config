import QtQuick
import QtQuick.Layouts
import Quickshell

import "./widgets"

PanelWindow {
    id: base

    property string baseColor

    property string elementIdleColor: "transparent"
    property string elementHoverColor: "transparent"

    property double elementRadius
    property double elementHeight: 12
    property double elementMargins: elementRadius

    implicitWidth: Screen.width

    anchors.top: true

    color: "transparent"

    RowLayout {
        anchors.fill: parent

        spacing: 5

        Rectangle {
            id: left

            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.leftMargin: 10

            color: base.baseColor
            radius: base.elementRadius

            RowLayout {
                anchors.fill: parent
                anchors.margins: base.elementMargins

                HyprlandBar {
                    Layout.fillWidth: true
                    implicitHeight: base.elementHeight

                    idleColor: base.elementIdleColor
                    hoverColor: base.elementHoverColor

                    idleWidthMult: 0.05
                    focusedWidthMult: 0.1
                    hoveredWidthMult: 0.2

                    indicatorDiameter: 7.5

                    radius: base.elementRadius
                }
            }
        }

        Rectangle {
            id: center

            implicitWidth: 250
            implicitHeight: base.height

            color: base.baseColor
            radius: base.elementRadius

            RowLayout {
                anchors.fill: parent
                anchors.margins: base.elementMargins

                ClockBar {
                    Layout.fillWidth: true
                    implicitHeight: base.elementHeight

                    fontFamily: "JetBrainsMono Nerd Font"
                }
            }
        }

        Rectangle {
            id: right

            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.rightMargin: 10

            color: base.baseColor
            radius: base.elementRadius

            RowLayout {
                anchors.fill: parent
                anchors.margins: base.elementMargins

                Wifi {
                    Layout.fillWidth: true
                    implicitHeight: base.elementHeight

                    idleColor: base.elementIdleColor
                    hoverColor: base.elementHoverColor

                    radius: base.elementRadius / Math.E
                }

                Notifications {
                    Layout.fillWidth: true
                    implicitHeight: base.elementHeight

                    idleColor: base.elementIdleColor
                    hoverColor: base.elementHoverColor

                    radius: base.elementRadius / Math.E
                }
            }
        }
    }
}
