pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland

Rectangle {
    id: bar_base

    color: "transparent"

    Transition {
        id: changeTween

        NumberAnimation {
            duration: 200
            property: "x, width"
            easing.type: Easing.InOutQuad
        }
    }

    property double idleWidthMult: 0.1
    property double hoveredWidthMult: 0.25
    property double focusedWidthMult: 0.2

    property string fontFamily: "monospace"

    property double indicatorDiameter: height

    Row {
        anchors.fill: parent

        add: changeTween
        move: changeTween

        Repeater {
            model: Hyprland.workspaces.values

            delegate: Rectangle {
                id: workspaceButton

                width: ((bar_base.width - cwLabel.width) / Hyprland.workspaces.values.length)
                height: Math.max(bar_base.height, bar_base.indicatorDiameter)

                color: "transparent"

                // This stores the workspace data!!!
                required property var modelData

                Rectangle {
                    id: indicator

                    width: workspaceButton.modelData.focused ? Math.max(parent.width * bar_base.focusedWidthMult, bar_base.indicatorDiameter) : Math.max(parent.width * bar_base.idleWidthMult, bar_base.indicatorDiameter)
                    height: parent.height

                    anchors.centerIn: parent

                    color: workspaceButton.modelData.focused ? "white" : "transparent"

                    border.color: "white"
                    border.width: 2

                    radius: bar_base.radius

                    Behavior on width {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    hoverEnabled: true

                    onEntered: {
                        indicator.width = Math.max(parent.width * bar_base.hoveredWidthMult, bar_base.indicatorDiameter);
                    }

                    onExited: {
                        indicator.width = workspaceButton.modelData.focused ? Math.max(parent.width * bar_base.focusedWidthMult, bar_base.indicatorDiameter) : Math.max(parent.width * bar_base.idleWidthMult, bar_base.indicatorDiameter);
                    }

                    onClicked: {
                        workspaceButton.modelData.activate();
                    }
                }
            }
        }

        Rectangle {
            id: cwLabel

            implicitWidth: cwText.implicitWidth * 1.5
            implicitHeight: parent.height

            radius: bar_base.radius / Math.E

            color: "#A0000000"

            Text {
                id: cwText

                font.family: bar_base.fontFamily
                font.weight: 600
                font.pixelSize: bar_base.height * 0.8

                color: "white"

                anchors.centerIn: parent

                text: (typeof (Number.parseInt(Hyprland.focusedWorkspace.name))) == "number" ? "WORKSPACE " + Hyprland.focusedWorkspace.name : Hyprland.focusedWorkspace.name
            }
        }
    }
}
