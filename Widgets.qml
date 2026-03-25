import QtQuick
import Quickshell
import Quickshell.Wayland

import "desktop_widgets" as Widgets

PanelWindow {
    id: root

    property double componentCornerRadius: 2

    property string componentFontFace: "monospace"
    property int componentFontSize: 12

    property color componentTextColor: "white"
    property color componentBGColor: "black"

    implicitWidth: Screen.width
    implicitHeight: Screen.height

    color: "transparent"

    WlrLayershell.exclusiveZone: -1 // do not get shoved by other quickshell widgets
    aboveWindows: false

    Widgets.Clock {
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
