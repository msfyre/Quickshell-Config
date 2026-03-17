import QtQuick

import Quickshell
import Quickshell.Wayland

import "./components/" as Components

PanelWindow {
    id: base

    WlrLayershell.layer: WlrLayer.Background

    property string componentFontFace: "monospace"

    implicitWidth: screen.width
    implicitHeight: screen.height

    color: "#000000"

    Components.Clock {
        anchors.centerIn: parent

        textColor: "white"

        fontFamily: base.componentFontFace
        fontPixelSize: 40
    }
}
