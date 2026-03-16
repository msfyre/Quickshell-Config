import QtQuick

import "." as HyprlandBar

Rectangle {
    id: base

    required property var modelData
    readonly property var workspace: modelData

    // Workspace Indicator properties
    property double wsIndicatorIdleWidth
    property double wsIndicatorHoverWidth
    property double wsIndicatorFocusedWidth
    property double wsIndicatorDiameter: height

    property string idleColor: "transparent"
    property string hoverColor: "#10FFFFFF"

    property string fontFamily: "monospace"
    property double fontPixelSize: 10

    property bool hovered: false

    anchors.verticalCenter: parent.verticalCenter

    color: hovered ? hoverColor : idleColor

    HyprlandBar.WorkspaceIndicator {
        id: workspaceIndicator

        width: base.hovered ? base.wsIndicatorHoverWidth : (base.workspace.focused ? base.wsIndicatorFocusedWidth : base.wsIndicatorIdleWidth)
        height: base.wsIndicatorDiameter

        radius: base.radius

        workspace: base.workspace
    }

    HyprlandBar.MonitorIndicator {
        id: monitorIndicator

        width: Math.max(workspaceIndicator.width * 1.1, monitorNameText.implicitWidth * 1.5)

        radius: base.radius / (Math.E / 2)
        opacity: base.hovered ? 1 : 0

        workspace: base.workspace

        fontFamily: base.fontFamily
        fontPixelSize: base.fontPixelSize
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: true

        onEntered: base.hovered = true

        onExited: base.hovered = false

        onClicked: {
            base.workspace.activate();
        }
    }
}
