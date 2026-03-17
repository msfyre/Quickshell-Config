import QtQuick

import Quickshell
import Quickshell.Wayland

import "utilities" as Utilities

PanelWindow {
    id: root

    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.exclusiveZone: -1 // do not get shoved by other quickshell widgets

    property string imageFilePath
    property string componentFontFace: "monospace"

    implicitWidth: screen.width
    implicitHeight: screen.height

    color: "#000000"

    Utilities.FileResolver {
        id: resolver
    }

    Image {
        id: bgImage

        anchors.fill: parent
        source: resolver.expandPath(root.imageFilePath)

        fillMode: Image.PreserveAspectFit
    }

    Behavior on imageFilePath {
        PropertyAnimation {
            target: bgImage
            from: 1
            to: 0
            property: "opacity"
            duration: 5000
        }
    }
}
