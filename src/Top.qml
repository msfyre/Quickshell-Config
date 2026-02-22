import QtQuick
import QtQuick.Layouts
import Quickshell

import "./widgets"

PanelWindow {
    id: base

    property string elementColor
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

            color: base.elementColor
            radius: base.elementRadius

            RowLayout {
                anchors.fill: parent
                anchors.margins: base.elementMargins

                HyprlandBar {
                    Layout.fillWidth: true
                    implicitHeight: base.elementHeight

                    radius: base.elementRadius
                }
            }
        }

        Rectangle {
            id: center

            implicitWidth: 250
            implicitHeight: base.height

            color: base.elementColor
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

            color: base.elementColor
            radius: base.elementRadius
        }
    }
}
