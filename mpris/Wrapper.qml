pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.Mpris

Item {
    id: root

    property MprisPlayer trackedPlayer: null
    property double trackedPlayerPosition: trackedPlayer.position
    readonly property string trackedPlayerIdentity: trackedPlayer.identity.toLowerCase()

    readonly property bool isTrackedPlayerPaused: trackedPlayer.playbackState == MprisPlaybackState.Paused

    readonly property MprisPlayer activePlayer: trackedPlayer ?? Mpris.players.values[0] ?? null

    Instantiator {
        model: Mpris.players

        Connections {
            required property MprisPlayer modelData
            target: modelData

            Component.onCompleted: {
                if (root.trackedPlayer == null || modelData.isPlaying) {
                    root.trackedPlayer = modelData;
                }
            }

            Component.onDestruction: {
                if (root.trackedPlayer == null || !root.trackedPlayer.isPlaying) {
                    for (const player of Mpris.players.values) {
                        if (player.playbackState.isPlaying) {
                            root.trackedPlayer = player;
                            break;
                        }
                    }

                    if (root.trackedPlayer == null && Mpris.players.values.length != 0) {
                        trackedPlayer = Mpris.players.values[0];
                    }
                }
            }

            function onPlaybackStateChanged() {
                if (root.trackedPlayer !== modelData) {
                    root.trackedPlayer = modelData;
                }
            }
        }
    }

    FrameAnimation {
        running: root.trackedPlayer.playbackState == MprisPlaybackState.Playing
        onTriggered: root.trackedPlayer.positionChanged()
    }
}
