pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Io

Rectangle {
    id: root

    required property string fontFace

    Text {
        width: parent.width
        height: parent.height

        // TODO: Add dynamic icons to indicate if you're connected
        // @msfyre (Jan. 30, 2026)
        text: "󰒢"

        anchors.centerIn: parent

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color: "white"

        font {
            family: root.fontFace
        }
    }

    Process {
        id: iwgtkProcess

        command: ["kitty", "impala"]
        running: false
    }

    MouseArea {
        width: parent.width
        height: parent.height

        onClicked: () => {
            iwgtkProcess.running = true;
        }
    }
}
