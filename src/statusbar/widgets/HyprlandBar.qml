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
                    id: workspaceIndicator

                    width: workspaceButton.modelData.focused ? Math.max(parent.width * bar_base.focusedWidthMult, bar_base.indicatorDiameter) : Math.max(parent.width * bar_base.idleWidthMult, bar_base.indicatorDiameter)
                    height: Math.min(bar_base.height / 2, bar_base.indicatorDiameter)

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                    color: workspaceButton.modelData.focused ? "white" : "transparent"

                    border.color: "white"
                    border.width: 2

                    radius: bar_base.radius

                    Behavior on width {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                Rectangle {
                    id: monitorIndicator

                    color: "#E0000000"

                    width: Math.max(workspaceIndicator.width * 1.2, monitorNameText.implicitWidth * 1.2)
                    height: parent.height

                    anchors.centerIn: parent

                    radius: bar_base.radius / Math.E

                    opacity: 0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 250
                        }
                    }

                    Text {
                        id: monitorNameText
                        text: "MONITOR " + (workspaceButton.modelData.monitor.id + 1)

                        color: "white"

                        font.family: bar_base.fontFamily
                        font.pixelSize: bar_base.fontPixelSize

                        anchors.centerIn: parent
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    hoverEnabled: true

                    onEntered: {
                        workspaceIndicator.width = Math.max(parent.width * bar_base.hoveredWidthMult, bar_base.indicatorDiameter);
                        monitorIndicator.opacity = 1;
                        workspaceButton.color = bar_base.hoverColor;
                    }

                    onExited: {
                        workspaceIndicator.width = workspaceButton.modelData.focused ? Math.max(parent.width * bar_base.focusedWidthMult, bar_base.indicatorDiameter) : Math.max(parent.width * bar_base.idleWidthMult, bar_base.indicatorDiameter);
                        monitorIndicator.opacity = 0;
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
                font.pixelSize: bar_base.fontPixelSize // FIXME: This is being overriden by something else

                color: "white"

                anchors.centerIn: parent

                text: (typeof (Number.parseInt(Hyprland.focusedWorkspace.name))) == "number" ? "WORKSPACE " + Hyprland.focusedWorkspace.name : Hyprland.focusedWorkspace.name
            }
        }
    }
}
