import QtQuick
import Quickshell
import Quickshell.Wayland

import "../utilities/"

PanelWindow {
    id: popupBase

    color: schemeGenerator.jsonAdapter.palettes.error[5]

    aboveWindows: true
    focusable: false

    visible: false

    WlrLayershell.layer: WlrLayer.Overlay

    implicitWidth: errorText.implicitWidth * 1.2
    implicitHeight: errorText.implicitHeight

    ColorSchemeGenerator {
        id: schemeGenerator
    }

    Text {
        id: errorText

        anchors.centerIn: parent

        color: schemeGenerator.jsonAdapter.palettes.primary[90]
    }

    function display(text: string, displayTimeMS: int) {
        visible = true;

        errorText.text = text;

        displayTimer.interval = displayTimeMS;
        displayTimer.start();
    }

    Timer {
        id: displayTimer
        interval: 5000

        onTriggered: {
            popupBase.visible = false;
        }
    }
}
