import QtQuick
import Quickshell.Io

Text {
    id: root

    text: "linus-torvalds" // placeholder

    Process {
        command: ["whoami"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.text = this.text.trim();
            }
        }
    }
}
