import QtQuick
import Quickshell.Io

import "./../../popups/"

Rectangle {
    id: bar_base

    required property string launcherName

    property string fontFamily
    property double fontPixelSize
    property string textColor

    property string idleColor: "transparent"
    property string hoverColor

    implicitWidth: displayText.implicitWidth * 1.2

    color: idleColor

    Process {
        id: launcher

        running: false
    }

    Error {
        id: errorWindow
    }

    Text {
        id: displayText

        text: "Launch App"

        anchors.centerIn: parent

        color: bar_base.textColor

        font.family: bar_base.fontFamily
        font.pixelSize: bar_base.fontPixelSize
    }

    function runLauncher() {
        if (launcherName == "rofi") {
            launcher.command = ["rofi", "-show", "drun"];
        } else {
            errorWindow.display(launcherName.toUpperCase() + " is an unsupported launcher!");
        }

        launcher.running = true;
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: true

        onEntered: {
            bar_base.color = bar_base.hoverColor;
        }

        onExited: {
            bar_base.color = bar_base.idleColor;
        }

        onClicked: {
            bar_base.runLauncher();
        }
    }

    Component.onCompleted: {
        radius /= Math.E;
    }
}
