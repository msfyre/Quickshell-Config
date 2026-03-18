import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Text {
    Layout.alignment: Qt.AlignVCenter
    text: " MONITOR " + (Hyprland.focusedWorkspace.monitor.id + 1)
}
