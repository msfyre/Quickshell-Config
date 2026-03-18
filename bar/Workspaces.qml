pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland

Item {
    id: root

    readonly property Transition moveTransition: Transition {
        NumberAnimation {
            property: "x"
            easing.type: Easing.OutBack
            duration: 200
        }
    }

    property string monitorIndicatorFontFace: "monospace"
    property double monitorIndicatorFontSize: 10 // pixels, not points.

    implicitWidth: row.implicitWidth + row.spacing
    implicitHeight: row.implicitHeight

    Row {
        id: row

        anchors.fill: parent
        spacing: 5

        add: root.moveTransition
        move: root.moveTransition

        Repeater {
            model: Hyprland.workspaces.values

            MouseArea {
                id: wsItem

                required property var modelData
                property HyprlandWorkspace workspace: modelData

                implicitWidth: workspace.focused ? 20 : 10
                implicitHeight: 10

                anchors.verticalCenter: parent.verticalCenter

                hoverEnabled: true

                Rectangle {
                    anchors.fill: parent

                    radius: width / 2
                }

                onClicked: {
                    workspace.activate();
                }
            }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: " MONITOR " + (Hyprland.focusedWorkspace.monitor.id + 1)
            color: "white"

            font.family: root.monitorIndicatorFontFace
            font.pixelSize: root.monitorIndicatorFontSize
        }
    }
}
