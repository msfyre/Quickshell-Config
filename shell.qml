pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import "./src/statusbar/"
import "./src/utilities/"
import "./src/wrappers"

Singleton {
    id: root

    ColorSchemeGenerator {
        id: schemeGenerator

        isDarkMode: false
        imageFilePath: wallpaperWrapper.currentWallpaper

        onJsonAdapterChanged: {
            console.log("Adapter updated!");
        }
    }

    SWWW {
        id: wallpaperWrapper
    }

    StatusBar {
        id: statusbar

        implicitHeight: 25

        elementHeight: (implicitHeight / 2) * 0.9
        elementRadius: 4

        baseColor: schemeGenerator.jsonAdapter.palettes.primary[10].color
        elementIdleColor: "transparent"
        elementHoverColor: schemeGenerator.jsonAdapter.palettes.primary[20].color
        elementFontFamily: "JetBrainsMono Nerd Font"
        elementFontPixelSize: 9
    }
}
