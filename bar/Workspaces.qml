pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland

Item {
    id: root

    readonly property HyprlandWorkspace activeWorkspace: Hyprland.focusedWorkspace
    readonly property HyprlandToplevel activeWindow: Hyprland.activeToplevel

    readonly property Transition moveTransition: Transition {
        NumberAnimation {
            properties: "x, width"
            easing.type: Easing.OutBack
            duration: 200
        }
    }

    property string elementColor: "white"
    property double elementHeight: 10
    property string elementFontFace: "monospace"

    // spacing is multiplied by 2 to account for the margin
    implicitWidth: layout.implicitWidth + layout.spacing
    implicitHeight: layout.implicitHeight

    onActiveWorkspaceChanged: {
        process_row.trackingWorkspace = root.activeWorkspace;
        tooltip.text = "";
    }

    Row {
        id: layout

        spacing: 7.5

        move: root.moveTransition

        Text {
            anchors.verticalCenter: parent.verticalCenter
            color: root.elementColor

            font.family: root.elementFontFace
            font.pixelSize: root.elementHeight
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "M" + (Hyprland.focusedWorkspace.monitor.id + 1) + ": WORKSPACE " + Hyprland.focusedWorkspace.id

            color: root.elementColor

            font.family: root.elementFontFace
            font.pixelSize: root.elementHeight * 1.2
        }

        Row {
            spacing: 5

            add: root.moveTransition
            move: root.moveTransition
            populate: root.moveTransition

            anchors.verticalCenter: parent.verticalCenter

            Repeater {
                model: Hyprland.workspaces.values

                MouseArea {
                    id: wsItem

                    required property var modelData
                    property HyprlandWorkspace workspace: modelData

                    property bool hovered: false

                    implicitWidth: hovered ? (workspace.focused ? 25 : 12.5) : (workspace.focused ? 20 : 10)
                    implicitHeight: root.elementHeight

                    anchors.verticalCenter: parent.verticalCenter

                    hoverEnabled: true

                    Rectangle {
                        id: fill

                        anchors.fill: parent

                        color: wsItem.workspace.focused ? root.elementColor : "transparent"

                        border.color: root.elementColor
                        border.width: 1.5

                        radius: 2

                        Behavior on color {
                            PropertyAnimation {
                                easing.type: Easing.InOutSine
                                duration: 100
                            }
                        }
                    }

                    onEntered: {
                        hovered = true;

                        if (!workspace.focused) {
                            tooltip.text = ">> WORKSPACE " + workspace.id + " |";
                        } else if (root.activeWorkspace.toplevels.values.length > 0) {
                            tooltip.text = ">> WINDOWS:";
                        } else {
                            tooltip.text = "No windows :(";
                        }

                        process_row.trackingWorkspace = workspace;
                    }

                    onExited: {
                        hovered = false;
                        process_row.trackingWorkspace = root.activeWorkspace;
                        tooltip.text = "";
                    }

                    onClicked: {
                        workspace.activate();
                    }

                    Behavior on implicitWidth {
                        PropertyAnimation {
                            easing.type: Easing.InOutSine
                            duration: 100
                        }
                    }
                }
            }
        }

        Text {
            id: tooltip

            anchors.verticalCenter: parent.verticalCenter

            text: ""
            color: root.elementColor
            visible: text.length > 0

            font.family: root.elementFontFace
            font.pixelSize: root.elementHeight * 1.1

            opacity: visible ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 250
                }
            }
        }

        Row {
            id: process_row

            anchors.verticalCenter: parent.verticalCenter

            // constants
            readonly property int characterLimitPerName: 20

            // vars
            property HyprlandWorkspace trackingWorkspace: root.activeWorkspace

            spacing: 10

            readonly property Transition animation: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 250
                }
                PropertyAnimation {
                    property: "x"
                    duration: 100
                }
            }

            add: animation

            // FIXME: This is still outputting the width even though visible is ticked off. (it depends on which window you saved last)
            // ADDENDUM: This bug doesn't happen if you restarted quickshell
            // ADDENDUM 2: it never appeared again wtf how
            // (@msfyre, 3/19/2026)
            Repeater {
                model: process_row.trackingWorkspace.toplevels

                Text {
                    required property int index
                    required property var modelData

                    property HyprlandToplevel toplevel: modelData

                    readonly property string textToRender: toplevel.title.length > process_row.characterLimitPerName
                    ? "..." + toplevel.title.substring(toplevel.title.length - process_row.characterLimitPerName, toplevel.title.length)
                    : toplevel.title

                    text: "* [" + (index + 1) + "] " + textToRender.toUpperCase()

                    color: root.elementColor
                    font.family: root.elementFontFace
                    font.pixelSize: root.elementHeight * 1.1
                }
            }
        }
    }
}
