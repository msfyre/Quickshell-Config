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
        componentFontSize: screen.height * 0.035
        componentFontColor: schemeGenerator.jsonAdapter.colors.primary.default.color

        imageFilePath: "~/Pictures/Wallpapers/Misc_MicrowaveArray.jpg"
    }

    Bar.Bar {
        implicitHeight: screen.height * 0.025

        barColor: schemeGenerator.jsonAdapter.colors.primary_container.default.color

        elementColor: schemeGenerator.jsonAdapter.colors.primary.default.color
        elementFontFace: "BigBlueTermPlus Nerd Font"
        elementFontSize: implicitHeight / Math.E
    }
}
