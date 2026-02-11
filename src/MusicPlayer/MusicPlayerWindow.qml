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
            running = true;
        }
    }

    Row {
        id: mainlayout

        anchors.fill: parent
        anchors.right: parent.right

        Rectangle {
            id: space

            width: parent.parent.width - (playing.width + rmpc_button.width)
            height: parent.parent.height

            color: "transparent"
        }

        Rectangle {
            id: playing

            width: playing_text.implicitWidth + (playing_text.anchors.leftMargin + playing_text.anchors.rightMargin)
            height: parent.height

            color: renderRoot.buttonColor

            radius: renderRoot.buttonRadius

            Behavior on width {
                NumberAnimation {
                    duration: text_opacity_animation.duration / 5
                }
            }

            Text {
                id: playing_text

                wrapMode: Text.NoWrap

                text: mpd_playing.track || "Nothing is playing right now..."

                anchors {
                    fill: parent
                    left: parent.left
                    leftMargin: 10
                    right: parent.right
                    rightMargin: 10
                    verticalCenter: parent.verticalCenter
                }

                font.family: renderRoot.buttonFontFamily
                font.pixelSize: renderRoot.buttonTextSize || renderRoot.height

                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter

                color: "white"

                Behavior on text {
                    PropertyAnimation {
                        id: text_opacity_animation

                        target: playing_text
                        property: "opacity"

                        from: 0
                        to: 1

                        duration: 500
                    }
                }
            }
        }

        Rectangle {
            id: rmpc_button

            implicitWidth: 75
            implicitHeight: parent.parent.height

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
