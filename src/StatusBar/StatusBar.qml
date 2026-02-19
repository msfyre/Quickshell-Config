import QtQuick
import Quickshell

PanelWindow {
    id: root

    property double layoutRadius;

    Row {
        anchors.fill: parent

        Rectangle {
            id: left_widgets

            width: parent.width / 3
            height: parent.height

            color: "transparent"

            anchors {
                top: parent.top
                topMargin: 5
                verticalCenter: parent.verticalCenter
            }

            Row {
                anchors.fill: parent

                spacing: 4


                HyprlandTab {
                    width: parent.width
                    height: parent.height

                    layoutRadius: root.layoutRadius

                    diameter: 8

                    color: "#020f24"
                }
            }
        }

        Rectangle {
            id: center_widgets

            width: parent.width / 3
            height: parent.height

            color: "transparent"

            Row {
                anchors.fill: parent

                Clock {
                    width: parent.width / 3
                    height: parent.height

                    radius: 5

                    anchors {
                        top: parent.top
                        topMargin: 2
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }

                    color: "#020F24"
                }
            }
        }

        Rectangle {
            id: right_widgets

            width: parent.width / 3
            height: parent.height

            color: "transparent"

            anchors {
                top: parent.top
                topMargin: 5
                verticalCenter: parent.verticalCenter
            }

            Row {
                anchors.fill: parent

                Hardware {
                    width: parent.width / 2
                    height: parent.height
                }
            }
        }
    }
}
