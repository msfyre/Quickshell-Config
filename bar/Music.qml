import QtQuick
import Quickshell.Services.Mpris

import "./../mpris" as Mpris

Text {
    property MprisPlayer player: Mpris.Fetcher.getPlayerByIdentity("mpd")
    text: player.trackTitle + " - " + player.trackArtist
}
