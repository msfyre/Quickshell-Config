pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import "bar" as Bar
import "wallpaper_selector" as WallpaperSelector
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
        componentTextColor: schemeGenerator.jsonAdapter.colors.primary.default.color ?? ""
        componentBGColor: schemeGenerator.jsonAdapter.colors.primary_container.default.color ?? ""
        componentCornerRadius: bar.barRadius * 2

        imageFilePath: WallpaperSelector.Values.adapter.wallpaper
    }

    Bar.Bar {
        id: bar

        anchors.top: true

        implicitHeight: screen.height * 0.0225

        barColor: schemeGenerator.jsonAdapter.colors.primary_container.default.color ?? ""

        elementColor: schemeGenerator.jsonAdapter.colors.primary.default.color ?? ""
        elementFontFace: "BigBlueTermPlus Nerd Font"
        elementFontSize: implicitHeight / Math.E
    }
}
