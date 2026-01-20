pragma ComponentBehavior: Bound

import QtQuick

Rectangle {
    id: root
    Text {
        id: timedisplay
        anchors.centerIn: parent

        color: "#FFFFFF"

        font.family: "JetBrainsMono Nerd Font"
        font.weight: 900
        font.pixelSize: 9
    }

    function updateTime() {
        const _date = new Date();

        const second = _date.getSeconds();
        const minute = _date.getMinutes();

        const hour24 = _date.getHours();
        const hourPM = hour24 - 12;

        const side = hour24 >= 12 ? "PM" : "AM";

        const timeFormat = `${String((hourPM > 0) ? hourPM : hour24).padStart(2, "0")}` + `:${String(minute).padStart(2, 0)}` + `:${String(second).padStart(2, "0")} ${side}`;

        timedisplay.text = `Time: ${timeFormat}`;
    }

    Timer {
        interval: 500
        running: true
        repeat: true

        onTriggered: {
            root.updateTime();
        }
    }
}
