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

    property double idleWidth: parent.width * 0.1
    property double hoveredWidth: parent.width * 0.35
    property double focusedWidth: parent.width * 0.3

    Row {
        anchors.fill: parent

        add: changeTween
        move: changeTween

        Repeater {
            model: Hyprland.workspaces.values

            delegate: Rectangle {
                id: workspaceButton

                width: ((bar_base.width - cwLabel.width) / Hyprland.workspaces.values.length)
                height: bar_base.height

                color: "transparent"

                required property var modelData // workspace

                Rectangle {
                    id: indicator

                    width: workspaceButton.modelData.focused ? bar_base.focusedWidth : bar_base.idleWidth
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
                        indicator.width = bar_base.hoveredWidth;
                    }

                    onExited: {
                        indicator.width = workspaceButton.modelData.focused ? bar_base.focusedWidth : bar_base.idleWidth;
                    }

                    onClicked: {
                        workspaceButton.modelData.activate();
                    }
                }
            }
        }

        Rectangle {
            id: cwLabel

            implicitWidth: 50
            implicitHeight: parent.height

            Text {
                text: Hyprland.focusedWorkspace.id
            }
        }
    }
}
