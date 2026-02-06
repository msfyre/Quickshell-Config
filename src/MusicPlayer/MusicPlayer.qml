pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

PanelWindow {
    id: window

    property int windowRadius

    property string buttonColor
    property int buttonRadius

    property string buttonFontFamily
    property int buttonTextSize

    MusicPlayerWindow {
        radius: window.windowRadius

        buttonColor: window.buttonColor
        buttonRadius: window.buttonRadius

        buttonFontFamily: window.buttonFontFamily
        buttonTextSize: window.buttonTextSize

        color: window.color
    }
}
