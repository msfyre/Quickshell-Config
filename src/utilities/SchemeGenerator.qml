pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: utilRoot

    property var jsonAdapter
    property string prevQuery

    Process {
        id: swwwQuery

        property string queriedPath

        command: ["swww", "query"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const output = this.text.trim();
                const grepped = output.match(/image: (.*)/);

                if (grepped && grepped[1]) {
                    swwwQuery.queriedPath = grepped[1].trim();

                    if (swwwQuery.queriedPath != utilRoot.prevQuery) {
                        schemeGen.running = true;
                        utilRoot.prevQuery = swwwQuery.queriedPath;
                    }
                }
            }
        }
    }

    Process {
        id: schemeGen

        command: ["sh", "-c", "matugen image " + swwwQuery.queriedPath + " -t scheme-tonal-spot -j hex -v > ~/.config/quickshell/.colorscheme.json"]
        running: false

        onRunningChanged: {
            if (!running) {
                console.log("Color scheme generation finished");

                schemeFileView.reload();
            }
        }
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
            console.log("JSON loaded");
            utilRoot.jsonAdapter = scheme_adapter;
        }
    }

    Timer {
        interval: 10
        running: true
        repeat: true

        onTriggered: {
            swwwQuery.running = true;
        }
    }
}
