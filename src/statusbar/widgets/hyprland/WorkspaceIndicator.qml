import QtQuick

Rectangle {
    id: base

    property var workspace

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    color: workspace.focused ? "white" : "transparent"

    border.color: "white"
    border.width: 2

    Behavior on width {
        NumberAnimation {
            duration: 250
            easing.type: Easing.InOutQuad
        }
    }
}
