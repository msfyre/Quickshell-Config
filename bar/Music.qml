import QtQuick
import Quickshell.Services.Mpris

import "./../mpris" as Mpris

Text {
    readonly property MprisPlayer player: Mpris.Fetcher.getPlayerByIdentity("mpd")

    readonly property string titleDisplayText: player.trackTitle.length > characterLimit ? player.trackTitle.substring(0, characterLimit) + "..." : player.trackTitle
    readonly property string displayText: player.playbackState == MprisPlaybackState.Playing ? `${titleDisplayText} - ${player.trackArtist}` : (player.playbackState == MprisPlaybackState.Paused ? `${titleDisplayText} - ${player.trackArtist} [PAUSED]` : "Uh... where's the music?")

    property int characterLimit: 20
    text: `󰎇 ${displayText}`
}
