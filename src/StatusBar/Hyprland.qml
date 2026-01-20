pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Rectangle {
    id: root

    required property double layoutRadius
    required property double layoutMargin

    required property double focusedWidth
    required property double focusedHeight

    required property double diameter

    property int wsCount: Hyprland.workspaces.values.length

    radius: layoutRadius

    RowLayout {
        id: wsLayout

        Layout.alignment: Qt.AlignCenter

        anchors {
            fill: parent
            verticalCenter: parent.verticalCenter
        }

        Repeater {
            id: wsInstancer

            model: Hyprland.workspaces

            delegate: Rectangle {
                id: workspaceBox

                required property var modelData

                Layout.fillWidth: true
                Layout.fillHeight: true

                color: "transparent"

                radius: root.layoutRadius

                Rectangle {
                    id: glow

                    width: workspaceBox.modelData.focused ? root.focusedWidth : root.diameter
                    height: workspaceBox.modelData.focused ? root.focusedHeight : root.diameter

                    radius: root.layoutRadius

                    color: workspaceBox.modelData.focused ? "#FFFFFF" : "transparent"
                    border.color: "#FFFFFF"
                    border.width: 2

                    anchors.centerIn: workspaceBox

                    // TODO: Animate the size change
                }

                MouseArea {
                    anchors.fill: workspaceBox
                    enabled: true
                    hoverEnabled: true
                    onEntered: {
                        workspaceBox.color = "#0AFFFFFF";
                    }
                    onExited: {
                        workspaceBox.color = "transparent";
                    }
                    onClicked: mouse => {
                        if (Hyprland.focusedWorkspace.id !== workspaceBox.modelData.id) {
                            Hyprland.dispatch(`workspace ${workspaceBox.modelData.id}`);
                        }
                    }
                }

                // TODO: Animate the size change
            }
        }

        Rectangle {
            id: workspaceIndicator

            width: 100
            Layout.fillHeight: true

            radius: root.layoutRadius

            anchors.centerIn: root

            color: "#10FFFFFF"

            Text {
                width: parent.width
                height: parent.height

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                text: `WORKSPACE ${Hyprland.focusedWorkspace.name}`

                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 10

                color: "white"
            }
        }
    }
}
