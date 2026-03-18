pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
    id: root

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
    implicitWidth: rowLayout.implicitWidth + (rowLayout.spacing * 2)
    implicitHeight: rowLayout.implicitHeight

    RowLayout {
        id: rowLayout

        anchors.fill: parent

        Text {
            Layout.alignment: Qt.AlignVCenter

            color: root.elementColor

            font.family: root.elementFontFace
            font.pixelSize: root.elementHeight
        }

        Text {
            Layout.alignment: Qt.AlignVCenter
            text: "M" + (Hyprland.focusedWorkspace.monitor.id + 1) + "|" + "W" + Hyprland.focusedWorkspace.id

            color: root.elementColor

            font.family: root.elementFontFace
            font.pixelSize: root.elementHeight
        }

        Row {
            id: row

            Layout.fillWidth: true
            spacing: 5

            add: root.moveTransition
            move: root.moveTransition
            populate: root.moveTransition

            Layout.alignment: Qt.AlignVCenter

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

                        color: wsItem.workspace.focused ? "white" : "transparent"

                        border.color: "white"
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
                    }

                    onExited: {
                        hovered = false;
                    }

                    onClicked: {
                        workspace.activate();
                    }
                }
            }
        }
    }
}
