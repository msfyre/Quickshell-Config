import QtQuick
import Quickshell.Io

Rectangle {
    Process {
        id: nc_process

        command: ["swaync-client", "-R", "-rs", "-t"]
        running: false
    }

    Text {
        anchors.centerIn: parent
        text: "󰂚"
        color: "white"
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            nc_process.running = true;
        }
    }
}
