pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

import "./src/"

Singleton {
    id: root

    // TODO: Make a way to read the JSON color scheme file as a JSON object
    FileView {
        id: colorSchemeJSON

        path: Qt.resolvedUrl("./color-scheme.json")
        watchChanges: true
        onFileChanged: reload()
    }

    Top {
        id: top

        implicitHeight: 25

        elementHeight: 10
        elementRadius: 5

        baseColor: "#00093f"

        elementIdleColor: "transparent"
        elementHoverColor: "#10FFFFFF"
    }
}
