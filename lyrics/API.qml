import QtQuick

Item {
    id: root

    readonly property string get_URL: "https://lrclib.net/api/get"
    readonly property string api_URL: "https://lrclib.net/api"

    readonly property int maxAttempts: 5
    property int attempt: 1

    property bool lyricsExist: songData.syncedLyrics !== null
    property var lyricsLines: songData.syncedLyrics.split("\n")

    property int fetchStatus: 0
    property var songData: ({})

    property string artist
    property string title
    property string album

    signal lyricsFetched

    function fetchSong() {
        var url = get_URL + "?artist_name=" + encodeURIComponent(artist) + "&track_name=" + encodeURIComponent(title) + "&album_name=" + encodeURIComponent(album);
        var req = new XMLHttpRequest();

        console.log("Initiating request...");
        console.log("URL:", url);

        songData = {};

        req.open("GET", url, true);
        req.onreadystatechange = function () {
            console.log("Attempt #" + root.attempt);

            if (req.readyState === XMLHttpRequest.DONE) {
                // 200: FOUND LYRICS
                // 400: Syntax error
                // 404: NOT FOUND (common shit why do you have to document this)
                root.fetchStatus = req.status;

                if (req.status === 200) {
                    try {
                        songData = JSON.parse(req.responseText);
                        lyricsFetched();
                    } catch (err) {
                        console.error("PARSE ERROR:\n", err);
                    }
                } else {
                    console.warn("STATUS:", req.status);
                    retryTimer.start();
                }
            }
        };
        req.send();
    }

    Timer {
        id: retryTimer

        interval: 250
        running: false

        onTriggered: {
            root.attempt++;

            if (root.attempt <= root.maxAttempts) {
                root.fetchSong();
            } else {
                root.lyricsFetched();
            }
        }
    }

    function lrcToSeconds(ts): real {
        const match = ts.match(/\[(\d+):(\d+)(?:\.(\d+))?\]/);
        if (!match)
            return null;

        const minutes = parseInt(match[1], 10);
        const seconds = parseInt(match[2], 10);
        let fraction = match[3] ? match[3] : "0";

        // normalize fraction (handles .xx vs .xxx)
        const ms = parseFloat("0." + fraction);

        return minutes * 60 + seconds + ms;
    }

    function secondsToLRC(totalsecs): string {
        const minutes = Math.floor(totalsecs / 60).toString().padStart(2, "0");
        const seconds = Math.floor(totalsecs % 60).toString().padStart(2, "0");
        const hundredths = Math.floor((totalsecs % 1) * 100).toString().padStart(2, "0");

        const timestamp = `[${minutes}:${seconds}.${hundredths}]`;

        return timestamp;
    }

    function stripLRCTimestamp(line): string {
        return line.replace(/^\[\d+:\d+(?:\.\d+)?\]\s*/, "");
    }

    onTitleChanged: {
        fetchSong();
    }

    onLyricsFetched: {
        console.log("Done!");

        lyricsExist = songData.syncedLyrics !== undefined;
        attempt = 1;

        if (lyricsExist)
            lyricsLines = songData.syncedLyrics.split("\n");
    }
}
