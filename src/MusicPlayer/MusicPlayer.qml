pragma ComponentBehavior: Bound

import QtQuick

import Quickshell

PanelWindow {
    id: root_msxplayer

    property string buttonColor: "gray"
    property string buttonTextColor: "white"

    property int buttonRadius

    property string buttonFontFamily: "monospace"
    property double buttonTextSize

    property double renderedWidth: msx_player_playing.width + msx_player_button.width

    Row {
        id: mainlayout

        anchors.fill: parent

        Rectangle {
            id: space
        }

        MusicPlayerButton {
            id: msx_player_button

            width: 50
            height: parent.height

            color: root_msxplayer.buttonColor

            radius: root_msxplayer.buttonRadius

            pixelFontSize: root_msxplayer.buttonTextSize
            fontFamily: root_msxplayer.buttonFontFamily
        }

        CurrentlyPlaying {
            id: msx_player_playing

            color: root_msxplayer.buttonColor

            radius: root_msxplayer.buttonRadius

            pixelFontSize: root_msxplayer.buttonTextSize
            fontFamily: root_msxplayer.buttonFontFamily
        }
    }
}
