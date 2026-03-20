import QtQuick
import Quickshell.Services.Mpris

import "./../mpris" as Mpris

Text {
    property MprisPlayer player: Mpris.Fetcher.getPlayerByIdentity("mpd")
    text: player.playbackState == MprisPlaybackState.Playing ? `CURRENTLY PLAYING: ${player.trackTitle} - ${player.trackArtist}` : (player.playbackState == MprisPlaybackState.Paused ? `${player.trackTitle} - ${player.trackArtist} [PAUSED]` : "Uh... where's the music?")
}
