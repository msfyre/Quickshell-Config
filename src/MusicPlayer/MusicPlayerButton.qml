import QtQuick
import Quickshell.Io

Rectangle {
    id: button

    property string fontFamily
    property double pixelFontSize

    Process {
        id: rmpc_process

        running: false
        command: ["kitty", "rmpc"]
    }

    Text {
        text: ""

        font.family: button.fontFamily
        font.pixelSize: button.pixelFontSize

        width: parent.width
        height: parent.height

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color: "white"
    }

    MouseArea {
        anchors.fill: parent

        onClicked: () => {
            rmpc_process.running = true;
        }
    }
}
