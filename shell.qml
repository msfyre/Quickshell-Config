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

        color: schemeGenerator.jsonAdapter.colors.background.default.color
        componentFontFace: "BigBlueTermPlus Nerd Font"
        componentFontSize: 24
        componentFontColor: schemeGenerator.jsonAdapter.colors.primary.default.color

        imageFilePath: "~/Pictures/Wallpapers/Misc_MicrowaveArray.jpg"
    }

    Bar.Bar {
        implicitHeight: screen.height * 0.025

        leftColor: schemeGenerator.jsonAdapter.colors.primary_container.default.color

        elementColor: schemeGenerator.jsonAdapter.colors.primary.default.color
        elementFontFace: "BigBlueTermPlus Nerd Font"
        elementFontSize: 8
    }
}
