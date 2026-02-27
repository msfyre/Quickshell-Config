pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland

Rectangle {
    id: bar_base

    color: "transparent"

    property double idleWidthMult: 0.1
    property double hoveredWidthMult: 0.25
    property double focusedWidthMult: 0.2

    property string fontFamily: "monospace"

    property double indicatorDiameter: height

    property string idleColor: "transparent"
    property string hoverColor: "transparent"

    Row {
        id: bar_row

        anchors.fill: parent

        spacing: 5

        Repeater {
            model: Hyprland.workspaces.values

            delegate: Rectangle {
                id: workspaceButton

                width: ((bar_base.width - cwLabel.width - (bar_row.spacing * Hyprland.workspaces.values.length)) / Hyprland.workspaces.values.length)
                height: bar_base.height

                color: "transparent"

                radius: bar_base.radius / Math.E

                anchors.verticalCenter: parent.verticalCenter

                // This stores the workspace data!!!
                required property var modelData

                Rectangle {
                    id: indicator

                    width: workspaceButton.modelData.focused ? Math.max(parent.width * bar_base.focusedWidthMult, bar_base.indicatorDiameter) : Math.max(parent.width * bar_base.idleWidthMult, bar_base.indicatorDiameter)
                    height: Math.min(bar_base.height, bar_base.indicatorDiameter)

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
                        workspaceButton.color = bar_base.hoverColor;
                    }

                    onExited: {
                        indicator.width = workspaceButton.modelData.focused ? Math.max(parent.width * bar_base.focusedWidthMult, bar_base.indicatorDiameter) : Math.max(parent.width * bar_base.idleWidthMult, bar_base.indicatorDiameter);
                        workspaceButton.color = bar_base.idleColor;
                    }

                    onClicked: {
                        workspaceButton.modelData.activate();
                    }
                }
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
                font.pixelSize: bar_base.height * 0.9

                color: "white"

                anchors.centerIn: parent

                text: (typeof (Number.parseInt(Hyprland.focusedWorkspace.name))) == "number" ? "Workspace " + Hyprland.focusedWorkspace.name : Hyprland.focusedWorkspace.name
            }
        }
    }
}
