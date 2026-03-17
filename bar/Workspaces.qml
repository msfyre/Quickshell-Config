pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

MouseArea {
    id: root

    required property var bar
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(bar.screen)

    implicitWidth: row.implicitWidth + row.spacing
    implicitHeight: row.implicitHeight

    Row {
        id: row

        anchors.fill: parent

        spacing: 5

        add: Transition {
            NumberAnimation {
                property: "x"
                easing.type: Easing.OutBack
                duration: 200
            }
        }

        Repeater {
            model: Hyprland.workspaces.values

            MouseArea {
                id: wsItem

                required property var modelData
                property HyprlandWorkspace workspace: modelData

                implicitWidth: 10
                implicitHeight: 10

                hoverEnabled: true

                Rectangle {
                    anchors.fill: parent
                }

                onClicked: {
                    workspace.activate();
                }
            }
        }

        Rectangle {
            id: wsName

            Text {
                text: "WORKSPACE " + Hyprland.focusedWorkspace.id

                color: "black"

                anchors.centerIn: parent
            }
        }
    }
}
