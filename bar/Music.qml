import QtQuick

import "./../mpris" as Mpris

Text {
    Mpris.Wrapper {
        id: controller
    }

    readonly property string displayText: controller.trackedPlayer.trackTitle + " - " + controller.trackedPlayer.trackArtist
    readonly property bool isMPD: controller.trackedPlayerIdentity === "music player daemon"

    text: controller.trackedPlayer.isPlaying && isMPD ? displayText : (controller.isTrackedPlayerPaused && isMPD ? displayText + " [PAUSED]" : "...dead air.")
}
