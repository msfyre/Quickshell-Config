pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import "bar" as Bar
import "utilities" as Utilities

ShellRoot {
    Utilities.ColorSchemeGenerator {
        id: schemeGenerator
        isDarkMode: true
        imageFilePath: bg.imageFilePath
        baseColor: "#000000"
    }

    BG {
        id: bg

        color: schemeGenerator.isDarkMode ? schemeGenerator.jsonAdapter.palettes.neutral[5].color : schemeGenerator.jsonAdapter.palettes.neutral[90].color
        componentFontFace: "JetBrainsMono Nerd Font"
        imageFilePath: "~/Pictures/Wallpapers/Misc_MicrowaveArray.jpg"
    }

    Bar.Bar {
        implicitHeight: screen.height * 0.025

        leftColor: schemeGenerator.jsonAdapter.palettes.primary[5].color

        elementFontFace: "JetBrainsMono Nerd Font"
        elementFontSize: 10
    }
}
