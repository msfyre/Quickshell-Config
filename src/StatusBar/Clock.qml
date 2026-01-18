import QtQuick

Rectangle {
    width: 165
    height: parent.height

    radius: 10

    color: "#020f24"

    Text {
        id: time
        anchors.centerIn: parent

        color: "#FFFFFF"

        font.family: "JetBrains Mono"
        font.weight: 900
        font.pixelSize: 10
    }

    function updateTime() {
        const _date = new Date();

        const second = _date.getSeconds();

        const minute = _date.getMinutes();

        const hour = _date.getHours();
        const hour12H = hour % 12;

        const side = hour > 12 ? "PM" : "AM";

        time.text = `${String(hour12H).padStart(2, "0")}` + `:${String(minute).padStart(2, 0)}` + `:${String(second).padStart(2, "0")} ${side}`;
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            updateTime();
        }
    }
}
