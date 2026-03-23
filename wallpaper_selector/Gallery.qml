pragma ComponentBehavior: Bound

import QtQuick
import Qt.labs.folderlistmodel

Rectangle {
    id: root

    property FolderListModel entries
    property color elementColor: "white"
    property string elementFontFace: "monospace"

    signal pathSelected(filepath: url)

    color: "transparent"

    onPathSelected: filepath => {
        Values.selectedImage = filepath;
    }

    Column {
        id: layout
        property int entryCountSqrt: Math.round(Math.sqrt(root.entries.count))

        anchors {
            fill: parent
        }

        Repeater {
            model: root.entries

            Item {
                id: gallery_item

                implicitWidth: parent.width
                implicitHeight: 25

                visible: !fileIsDir

                required property string fileName
                required property bool fileIsDir
                required property url fileUrl

                MouseArea {
                    id: gallery_item_mouse

                    anchors.fill: parent
                    hoverEnabled: true

                    Rectangle {
                        anchors.fill: parent
                        opacity: gallery_item_mouse.containsMouse ? 0.1 : 0
                    }

                    onClicked: {
                        root.pathSelected(gallery_item.fileUrl);
                    }
                }

                Row {
                    anchors.fill: parent
                    spacing: 10

                    Image {
                        source: gallery_item.fileIsDir ? "" : gallery_item.fileUrl
                        sourceSize.height: parent.height
                    }

                    Text {
                        text: gallery_item.fileName

                        color: root.elementColor
                        font.family: root.elementFontFace
                        font.pixelSize: gallery_item.implicitHeight / Math.E

                        anchors {
                            verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
}
