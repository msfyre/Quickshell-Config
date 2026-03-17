pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import "./Globals.qml"
import "bar" as Bar
import "utilities" as Utilities

ShellRoot {
    Utilities.ColorSchemeGenerator {
        id: schemeGenerator
        isDarkMode: true
        imageFilePath: bg.imageFilePath
    }

    BG {
        id: bg

        color: schemeGenerator.isDarkMode ? schemeGenerator.jsonAdapter.palettes.neutral[5].color : schemeGenerator.jsonAdapter.palettes.neutral[90].color
        componentFontFace: "JetBrainsMono Nerd Font"
        imageFilePath: "~/Pictures/Wallpapers/Misc_MicrowaveArray.jpg"
    }

    Bar.Bar {
        height: screen.height * 0.025
    }
}
