pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    function getPlayerByIdentity(searchIdentity: string): MprisPlayer {
        const players = Mpris.players.values;

        for (const player of players) {
            if (player.identity.toLowerCase() == searchIdentity.toLowerCase()) {
                return player;
            }
        }
    }
}
