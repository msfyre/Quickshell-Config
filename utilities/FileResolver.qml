import QtQuick
import Quickshell.Io

Item {
    id: root

    property string username

    // Needed to parse the home directory
    readonly property Process whoAmI: Process {
        property string username: ""

        command: ["whoami"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.username = this.text.trim();
            }
        }
    }

    function expandPath(path) {
        if (path.startsWith("~")) {
            return "/home/" + root.username + path.substring(1);
        }

        return path;
    }
}
