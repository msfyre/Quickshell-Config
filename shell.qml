pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import "utilities" as Utilities

ShellRoot {
    Utilities.ColorSchemeGenerator {
        id: schemeGenerator
        isDarkMode: true
        baseColor: "#000000"
    }

    BG {
        color: schemeGenerator.isDarkMode ? schemeGenerator.jsonAdapter.palettes.neutral[5].color : schemeGenerator.jsonAdapter.palettes.neutral[90].color
        componentFontFace: "JetBrainsMono Nerd Font"
        imageFilePath: "~/Pictures/Wallpapers/Misc_MicrowaveArray.jpg"
    }
}
