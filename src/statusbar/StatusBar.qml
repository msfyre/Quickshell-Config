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

                User {
                    implicitHeight: base.elementHeight

                    radius: base.elementRadius

                    fontFamily: "JetBrainsMono Nerd Font"
                }

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

                    fontFamily: "JetBrainsMono Nerd Font"
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

            bottomLeftRadius: base.elementRadius
            bottomRightRadius: base.elementRadius

            Behavior on color {
                ColorAnimation {
                    duration: 1000
                }
            }

            Row {
                anchors.fill: parent
                anchors.margins: base.elementMargins

                Layout.alignment: Qt.AlignRight

                spacing: 0

                AudioMixer {
                    Layout.fillWidth: true
                    implicitHeight: base.elementHeight * 1.25

                    idleColor: base.elementIdleColor
                    hoverColor: base.elementHoverColor

                    radius: base.elementRadius / Math.E

                    fontFamily: "JetBrainsMono Nerd Font"

                    anchors.verticalCenter: parent.verticalCenter
                }

                Wifi {
                    Layout.fillWidth: true
                    implicitHeight: base.elementHeight * 1.25

                    idleColor: base.elementIdleColor
                    hoverColor: base.elementHoverColor

                    radius: base.elementRadius / Math.E

                    fontFamily: "JetBrainsMono Nerd Font"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Notifications {
                    Layout.fillWidth: true
                    implicitHeight: base.elementHeight * 1.25

                    idleColor: base.elementIdleColor
                    hoverColor: base.elementHoverColor

                    radius: base.elementRadius / Math.E

                    fontFamily: "JetBrainsMono Nerd Font"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
