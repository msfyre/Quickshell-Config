pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Io

Item {
    id: utilRoot

    property bool isDarkMode: true
    property string imageFilePath

    property var jsonAdapter

    Process {
        id: schemeGenerator

        running: false

        stderr: StdioCollector {
            onStreamFinished: {
                if (this.text.length > 0) {
                    console.log(this.text.trim());
                }
            }
        }
        onExited: exitStatus => {
            if (exitStatus == 0) {
                console.log("Reloading scheme...");
                schemeFileView.reload();
            }
        }
    }

    function generateScheme() {
        console.log("Generating scheme...");

        if (utilRoot.imageFilePath.length === 0) {
            console.error("No path specified!");
            return;
        }

        console.log("Path:", utilRoot.imageFilePath);

        schemeGenerator.command = ["sh", "-c", "matugen image -t scheme-tonal-spot -j hex --source-color-index 0 " + (isDarkMode ? "-m dark '" : "-m light '") + utilRoot.imageFilePath + "' > ~/.config/quickshell/.colorscheme.json"];
        schemeGenerator.running = true;
    }

    FileView {
        id: schemeFileView

        path: Qt.resolvedUrl("../../.colorscheme.json")

        blockLoading: true

        JsonAdapter {
            id: scheme_adapter

            property var colors
            property var palettes
            property var image
            property var mode
            property var is_dark_mode
        }

        onLoaded: {
            if (scheme_adapter != null) {
                utilRoot.jsonAdapter = scheme_adapter;
            }
        }
    }

    onImageFilePathChanged: {
        generateScheme();
    }
}
