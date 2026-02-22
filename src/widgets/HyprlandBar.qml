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

    Row {
        anchors.fill: parent

        add: changeTween
        move: changeTween

        Repeater {
            model: Hyprland.workspaces.values

            delegate: Rectangle {
                id: workspaceButton

                width: bar_base.width / Hyprland.workspaces.values.length
                height: bar_base.height

                color: "transparent"

                required property var modelData // workspace

                Rectangle {
                    id: indicator

                    width: parent.width * 0.25
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
                        indicator.width = parent.width * 0.35;
                    }

                    onExited: {
                        indicator.width = parent.width * 0.25;
                    }

                    onClicked: {
                        workspaceButton.modelData.activate();
                    }
                }
            }
        }
    }
}
