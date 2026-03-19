import QtQuick

import "./../mpris" as Mpris

Text {
    Mpris.Wrapper {
        id: controller
    }

    readonly property string displayText: controller.trackedPlayer.trackTitle + " - " + controller.trackedPlayer.trackArtist
    readonly property bool isMPD: controller.trackedPlayerIdentity === "music player daemon"

    text: controller.trackedPlayer.isPlaying ? displayText : (controller.isTrackedPlayerPaused ? displayText + " [PAUSED]" : "...dead air.")
}
