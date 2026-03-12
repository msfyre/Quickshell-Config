import QtQuick
import Quickshell.Io

Item {
    id: wrapperRoot

    property string currentWallpaper

    Process {
        id: swwwQuery

        command: ["swww", "query"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const output = this.text.trim();
                const grepped = output.match(/image:(.*)/);

                if (grepped && grepped[1]) {
                    wrapperRoot.currentWallpaper = grepped[1].trim();
                }
            }
        }
    }

    Timer {
        interval: 500
        running: true
        repeat: true

        onTriggered: {
            swwwQuery.running = true;
        }
    }

    onCurrentWallpaperChanged: {
        console.log("A new wallpaper has been set: " + currentWallpaper);
    }
}
