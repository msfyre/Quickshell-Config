import QtQuick
import QtQuick.Dialogs

Item {
    id: root

    property url selectedFolder

    signal requestOpen

    FolderDialog {
        id: selector

        onAccepted: {
            root.selectedFolder = selector.selectedFolder;
        }
    }

    onRequestOpen: function () {
        selector.open();
    }
}
