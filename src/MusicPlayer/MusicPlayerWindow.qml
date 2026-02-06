pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Io

Rectangle {
    id: renderRoot

    property int buttonRadius
    property string buttonColor: "gray"

    property string buttonFontFamily: "monospace"
    property string buttonTextColor: "white"
    property int buttonTextSize

    width: parent.width
    height: parent.height

    anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }

    Process {
        id: rmpc_process

        running: false
        command: ["kitty", "rmpc"]
    }

    Process {
        id: mpd_playing

        property string track

        running: true
        command: ["mpc", "current"]

        stdout: StdioCollector {
            onStreamFinished: () => {
                mpd_playing.track = this.text;
            }
        }

        onRunningChanged: () => {
            mpd_playing.running = true;
        }
    }

    RowLayout {
        id: mainlayout

        anchors.fill: parent

        Layout.alignment: Qt.AlignRight

        // TODO: ADD MORE BUTTONS
        // @msfyre, (Feb. 4, 2026)

        Rectangle {
            id: playing

            Layout.fillWidth: true
            Layout.fillHeight: true

            implicitWidth: 0

            radius: renderRoot.buttonRadius || 0

            color: renderRoot.buttonColor

            Text {
                id: playing_text

                text: mpd_playing.track || "Nothing's playing!"

                anchors {
                    left: parent.left
                    leftMargin: 10
                    right: parent.right
                    rightMargin: 10
                }

                font.family: renderRoot.buttonFontFamily
                font.pixelSize: renderRoot.buttonTextSize || renderRoot.height

                width: parent.width
                height: parent.height

                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter

                color: "white"

                Component.onCompleted: () => {
                    playing.implicitWidth = playing_text.contentWidth;
                }
            }
        }

        Rectangle {
            id: rmpc_button

            width: 50
            Layout.fillHeight: true

            color: renderRoot.buttonColor

            radius: renderRoot.buttonRadius || 0

            Text {
                text: ""

                font.family: renderRoot.buttonFontFamily
                font.pixelSize: renderRoot.buttonTextSize || renderRoot.height

                width: parent.width
                height: parent.height

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                color: "white"
            }

            MouseArea {
                width: rmpc_button.width
                height: rmpc_button.height

                onClicked: () => {
                    rmpc_process.running = true;
                }
            }
        }
    }
}
