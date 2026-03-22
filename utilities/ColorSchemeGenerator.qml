pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property bool isDarkMode: true
    property color baseColor
    property string imageFilePath

    property var jsonAdapter

    Process {
        id: schemeGenerator

        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                console.log(this.text.trim());
            }
        }

        stderr: StdioCollector {
            onStreamFinished: {
                if (this.text.length > 0) {
                    console.log(this.text.trim());
                }
            }
        }

        onExited: (param1, exitStatus) => {
            console.log(param1, exitStatus);

            if (exitStatus === 0) {
                console.log("Reloading scheme...");
                schemeFileView.reload();
            } else {
                running = true;
            }
        }
    }

    function generateScheme() {
        console.log("Generating scheme...");

        if (root.imageFilePath.length === 0) {
            console.warn("No path specified!");
        }

        console.log("Path:", root.imageFilePath);
        console.log(`${Quickshell.shellDir}/.colorscheme.json`);

        if (root.imageFilePath != null) {
            schemeGenerator.command = ["sh", "-c", `matugen image -j hex --source-color-index 0 ${(isDarkMode ? "-m dark " : "-m light ")} "${root.imageFilePath}" > ${Quickshell.shellDir}/.colorscheme.json`];
            schemeGenerator.running = true;
        }
    }

    FileView {
        id: schemeFileView

        path: `${Quickshell.shellDir}/.colorscheme.json`

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
                root.jsonAdapter = scheme_adapter;
            }
        }
    }

    onImageFilePathChanged: {
        generateScheme();
    }
}
