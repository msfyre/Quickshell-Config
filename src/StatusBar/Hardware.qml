pragma ComponentBehavior: Bound

import QtQuick

Rectangle {
    id: renderRoot

    property int buttonRadius

    color: "transparent"

    Row {
        anchors.fill: parent

        Audio {
            width: parent.width / 2
            height: parent.height

            radius: root.layoutRadius

            color: "#020F24"
        }

        Wifi {
            width: parent.width / 2
            height: parent.height

            radius: root.layoutRadius

            color: "#020F24"
        }
    }
}
