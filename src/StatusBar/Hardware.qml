pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: renderRoot

    property int buttonRadius

    RowLayout {
        width: parent.width
        height: parent.height

        Audio {
            Layout.fillWidth: true
            Layout.fillHeight: true

            radius: renderRoot.buttonRadius

            color: "#020F24"
        }

        Wifi {
            Layout.fillWidth: true
            Layout.fillHeight: true

            radius: renderRoot.buttonRadius

            color: "#020F24"
        }
    }
}
