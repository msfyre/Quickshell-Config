import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import Quickshell

// TODO: Polish the GUI
// @msfyre, 3/23/2026

FloatingWindow {
    id: root

    // closed by default
    visible: false

    color: "transparent"

    property string elementFontFace: "monospace"
    property double elementFontSize
    property color elementTextColor: "white"

    Selector {
        id: selector
    }

    FolderListModel {
        id: selector_entries
        folder: selector.selectedFolder
        nameFilters: ["*.png", "*.jpg"]
    }

    ColumnLayout {
        anchors {
            fill: parent
            margins: 7.5
        }

        spacing: 0

        MouseArea {
            Layout.alignment: Qt.AlignLeft

            implicitWidth: 20
            implicitHeight: 20

            Rectangle {
                anchors.fill: parent
            }

            onClicked: function () {
                selector.requestOpen();
            }
        }

        Gallery {
            id: gallery

            Layout.fillWidth: true
            Layout.fillHeight: true

            entries: selector_entries

            elementColor: root.elementTextColor
            elementFontFace: root.elementFontFace

            onPathSelected: {
                root.visible = false;
            }
        }

        Text {
            text: "CURRENT FOLDER: " + (selector.selectedFolder.toString().substring(7))
            color: root.elementTextColor
            font.family: root.elementFontFace
            font.pixelSize: root.elementFontSize
        }
        Text {
            text: "SELECTED: " + (Values.selectedImage.toString().substring(7))
            color: root.elementTextColor
            font.family: root.elementFontFace
            font.pixelSize: root.elementFontSize
        }
    }
}
