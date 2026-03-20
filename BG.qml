import QtQuick
import Quickshell
import Quickshell.Wayland

import "."
import "utilities" as Utilities
import "lyrics" as Lyrics

PanelWindow {
    id: root

    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.exclusiveZone: -1 // do not get shoved by other quickshell widgets

    property string imageFilePath
    property string componentFontFace: "monospace"
    property int componentFontSize: 12
    property color componentFontColor: "white"

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

        fillMode: Image.PreserveAspectCrop
    }

    Lyrics.Display {
        anchors {
            left: parent.left
            leftMargin: 10
            bottom: parent.bottom
            bottomMargin: 10
        }

        maximumLinesVisible: 5

        componentColor: root.componentFontColor
        componentFontFace: root.componentFontFace
        componentFontSize: root.componentFontSize * 0.6
    }

    Clock {
        anchors {
            right: parent.right
            rightMargin: 10
            bottom: parent.bottom
            bottomMargin: 10
        }

        componentFontFace: root.componentFontFace
        componentFontSize: root.componentFontSize
        componentFontColor: root.componentFontColor
    }
}
