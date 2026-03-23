import QtQuick
import Quickshell
import Quickshell.Wayland

import "bg_components" as Components

PanelWindow {
    id: root

    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.exclusiveZone: -1 // do not get shoved by other quickshell widgets

    property url imageFilePath

    property double componentCornerRadius: 2

    property string componentFontFace: "monospace"
    property int componentFontSize: 12

    property color componentTextColor: "white"
    property color componentBGColor: "black"

    implicitWidth: screen.width
    implicitHeight: screen.height

    color: "#000000"

    Image {
        id: bgImage

        anchors.fill: parent
        source: root.imageFilePath

        fillMode: Image.PreserveAspectCrop
    }

    Components.Clock {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 10
        }

        componentFontFace: root.componentFontFace
        componentFontSize: root.componentFontSize
        componentTextColor: root.componentTextColor

        componentBGColor: root.componentBGColor
        componentCornerRadius: root.componentCornerRadius
    }
}
