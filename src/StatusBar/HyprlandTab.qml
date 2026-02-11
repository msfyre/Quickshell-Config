pragma ComponentBehavior: Bound

import QtQuick

import Quickshell.Hyprland

Rectangle {
    id: renderRoot

    required property double layoutRadius

    required property double diameter

    property int wsCount: Hyprland.workspaces.values.length
    property var focusedWorkspace: Hyprland.workspaces.values[0]

    radius: layoutRadius

    Row {
        id: wslayout

        spacing: 0

        add: Transition {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutSine
                properties: "x, width, opacity"
            }
        }

        move: Transition {
            NumberAnimation {
                duration: 100
                easing.type: Easing.InOutSine
                properties: "x, width"
            }
        }

        anchors {
            fill: renderRoot
        }

        Repeater {
            id: repeater

            model: Hyprland.workspaces

            property double delegateWidth: (((renderRoot.width - wsLayoutLabel.width) / renderRoot.wsCount)) - (wslayout.spacing)

            property double initialBeanWidth: delegateWidth * 0.1
            property double focusedBeanWidth: delegateWidth * 0.15
            property double hoverBeanWidth: delegateWidth * 0.25

            delegate: Rectangle {
                id: workspaceButton

                required property var modelData

                implicitWidth: repeater.delegateWidth
                implicitHeight: renderRoot.height

                radius: renderRoot.layoutRadius

                color: "transparent"

                Behavior on color {
                    PropertyAnimation {
                        duration: 100
                    }
                }

                Rectangle {
                    id: bean

                    property bool hovered: false
                    property double initialWidth: Math.max(repeater.initialBeanWidth, renderRoot.diameter)
                    property double focusedWidth: Math.max(repeater.focusedBeanWidth, renderRoot.diameter)
                    property double hoverWidth: Math.max(repeater.hoverBeanWidth, renderRoot.diameter)

                    width: hovered ? hoverWidth : (workspaceButton.modelData.focused ? focusedWidth : initialWidth)
                    height: renderRoot.diameter

                    radius: renderRoot.layoutRadius

                    anchors.centerIn: parent

                    color: workspaceButton.modelData.focused ? "white" : "transparent"

                    border {
                        color: "white"
                        width: 2
                    }

                    Behavior on width {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on color {
                        PropertyAnimation {
                            duration: 250
                            easing.type: Easing.OutQuad
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: () => {
                        workspaceButton.color = "#0AFFFFFF";
                        bean.hovered = true;
                    }
                    onExited: () => {
                        workspaceButton.color = "transparent";
                        bean.hovered = false;
                    }
                    onClicked: workspaceButton.modelData.activate()
                }
            }
        }

        Rectangle {
            id: wsLayoutLabel

            implicitWidth: 85
            implicitHeight: renderRoot.height

            color: "#40000000"

            radius: renderRoot.layoutRadius

            Text {
                anchors.centerIn: parent
                text: "WORKSPACE " + Hyprland.focusedWorkspace.id

                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: parent.height * 0.5
                color: "white"
            }
        }
    }
}
