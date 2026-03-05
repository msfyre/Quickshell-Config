pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import "./src/statusbar/"
import "./src/utilities/"

Singleton {
    id: root

    SchemeGenerator {
        id: schemeGen
    }

    StatusBar {
        id: top

        implicitHeight: 25

        elementHeight: 10
        elementRadius: 5

        baseColor: schemeGen.jsonAdapter.palettes.primary[5]

        elementIdleColor: "transparent"
        elementHoverColor: schemeGen.jsonAdapter.palettes.primary[10]
    }
}
