pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

import "./src/"

Singleton {
    id: root

    // TODO: Make a way to read the JSON color scheme file

    Top {
        id: top

        implicitHeight: 25

        elementHeight: 10
        elementRadius: 5
        elementColor: "#121318"
    }
}
