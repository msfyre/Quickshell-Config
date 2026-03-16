import QtQuick

Rectangle {
    id: base

    color: "#D0000000"

    height: monitorNameText.implicitHeight * 1.1

    anchors.centerIn: parent

    property var workspace

    property string fontFamily: "monospace"
    property double fontPixelSize: 10

    readonly property Text monitorNameText: _monitorNameText

    opacity: 0

    Behavior on opacity {
        NumberAnimation {
            duration: 250
        }
    }

    Text {
        id: _monitorNameText
        text: "MONITOR" + (base.workspace.monitor.id + 1) ?? "UNKNOWN_MONITOR"

        anchors.centerIn: parent

        color: "white"

        font.family: base.fontFamily
        font.pixelSize: base.fontPixelSize
    }
}
