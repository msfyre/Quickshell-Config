pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland

import "./WorkspaceInstance.qml"

Rectangle {
    id: bar_base

    color: "transparent"

    property double idleWidthMult: 0.1
    property double hoveredWidthMult: 0.25
    property double focusedWidthMult: 0.2

    property string fontFamily: "monospace"
    property double fontPixelSize: 10

    property double indicatorDiameter: height

    property string idleColor: "transparent"
    property string hoverColor: "transparent"

    anchors.verticalCenter: parent.verticalCenter

    Row {
        id: bar_row

        anchors.fill: parent

        spacing: 5

        add: Transition {
            PropertyAnimation {
                properties: "x, width"
                easing.type: Easing.OutSine
                duration: 200
            }
        }

        Repeater {
            model: Hyprland.workspaces

            delegate: WorkspaceInstance {
                width: ((bar_base.width - cwLabel.width - (bar_row.spacing * Hyprland.workspaces.values.length)) / Hyprland.workspaces.values.length)
                height: bar_base.height

                radius: bar_base.radius

                wsIndicatorIdleWidth: Math.max(width * bar_base.idleWidthMult, bar_base.indicatorDiameter)
                wsIndicatorHoverWidth: Math.max(width * bar_base.hoveredWidthMult, bar_base.indicatorDiameter)
                wsIndicatorFocusedWidth: Math.max(width * bar_base.focusedWidthMult, bar_base.indicatorDiameter)
                wsIndicatorDiameter: bar_base.indicatorDiameter

                fontFamily: bar_base.fontFamily
                fontPixelSize: bar_base.fontPixelSize

                idleColor: bar_base.idleColor
                hoverColor: bar_base.hoverColor
            }
        }

        Rectangle {
            id: cwLabel

            implicitWidth: cwText.implicitWidth * 1.35
            implicitHeight: parent.height * (3 / 2)

            radius: bar_base.radius / Math.E

            anchors.verticalCenter: parent.verticalCenter

            color: "#A0000000"

            Text {
                id: cwText

                font.family: bar_base.fontFamily
                font.pixelSize: bar_base.fontPixelSize // FIXME: This is being overriden by something else

                color: "white"

                anchors.centerIn: parent

                text: (typeof (Number.parseInt(Hyprland.focusedWorkspace.name))) == "number" ? "WORKSPACE " + Hyprland.focusedWorkspace.name : Hyprland.focusedWorkspace.name
            }
        }
    }
}
