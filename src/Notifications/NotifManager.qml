import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: notifManager

    property var notiflist: []

    NotificationServer {
        id: notifServer
    }

    Connections {
        target: notifServer
        function onNotification(notif) {
            console.log("Received!");
            console.log(notifManager.notiflist.length);

            notif.tracked = true;

            notifManager.notiflist.unshift(notif);

            notif.closed.connect(reason => {
                const idx = notifManager.notiflist.indexOf(notif);
                if (idx !== -1)
                    notifManager.notiflist.remove(idx);
            });
        }
    }
}
