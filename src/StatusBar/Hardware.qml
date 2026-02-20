pragma ComponentBehavior: Bound

import QtQuick

Rectangle {
    id: renderRoot

    property string buttonColor
    property double buttonRadius

    color: "transparent"

    Row {
        anchors.fill: parent

        Audio {
            width: parent.width / 2
            height: parent.height

            radius: renderRoot.buttonRadius

            color: buttonColor
        }

        Wifi {
            width: parent.width / 2
            height: parent.height

            radius: renderRoot.buttonRadius

            color: buttonColor
        }
    }
}
