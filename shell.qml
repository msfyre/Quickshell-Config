pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import "bar" as Bar
import "wallpaper" as Wallpaper
import "utilities" as Utilities

ShellRoot {
    id: root

    Utilities.ColorSchemeGenerator {
        id: schemeGenerator
        isDarkMode: true
        imageFilePath: bg.imageFilePath.toString().substring(7)
        baseColor: "#000000"
    }

    BG {
        id: bg

        color: schemeGenerator.jsonAdapter.colors.background.default.color ?? "black"
        componentFontFace: "BigBlueTermPlus Nerd Font"
        componentFontSize: screen.height * 0.035
        componentFontColor: schemeGenerator.jsonAdapter.colors.primary.default.color ?? "white"

        imageFilePath: Wallpaper.Values.selectedImage ?? "file:///home/msfyre/Pictures/Wallpapers/Terraria_Base.jpg"
    }

    Bar.Bar {
        id: bar

        implicitHeight: screen.height * 0.025

        barColor: schemeGenerator.jsonAdapter.colors.primary_container.default.color ?? ""

        elementColor: schemeGenerator.jsonAdapter.colors.primary.default.color ?? ""
        elementFontFace: "BigBlueTermPlus Nerd Font"
        elementFontSize: implicitHeight / Math.E
    }
}
