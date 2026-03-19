import QtQuick

Item {
    id: root

    readonly property string get_URL: "https://lrclib.net/api/get"
    readonly property string api_URL: "https://lrclib.net/api"

    property bool lyricsExist: songData.syncedLyrics !== null
    property var lyricsLines: songData.syncedLyrics.split("\n")

    property var songData: ({})

    property string artist
    property string title

    signal lyricsFetched

    function fetchSong() {
        var url = get_URL + "?artist_name=" + encodeURIComponent(artist) + "&track_name=" + encodeURIComponent(title);
        var req = new XMLHttpRequest();
        req.open("GET", url, true);
        req.onreadystatechange = function () {
            if (req.readyState === XMLHttpRequest.DONE) {
                // 200: FOUND LYRICS
                // 400: Syntax error
                // 404: NOT FOUND (common shit why do you have to document this)

                if (req.status === 200) {
                    try {
                        songData = JSON.parse(req.responseText);
                        lyricsFetched();
                    } catch (err) {
                        console.error("PARSE ERROR:\n", err);
                    }
                } else {
                    console.warn("STATUS:", req.status);
                }
            }
        };
        req.send();
    }

    function lrcToSeconds(ts) {
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

    function secondsToLRC(totalsecs) {
        const minutes = Math.floor(totalsecs / 60).toString().padStart(2, "0");
        const seconds = Math.floor(totalsecs % 60).toString().padStart(2, "0");
        const hundredths = Math.floor((totalsecs % 1) * 100).toString().padStart(2, "0");

        const timestamp = `[${minutes}:${seconds}.${hundredths}]`;
    }

    function stripLRCTimestamp(line) {
        return line.replace(/^\[\d+:\d+(?:\.\d+)?\]\s*/, "");
    }

    onArtistChanged: {
        fetchSong();
    }

    onTitleChanged: {
        fetchSong();
    }

    onLyricsFetched: {
        lyricsExist = songData.syncedLyrics !== null;
        lyricsLines = songData.syncedLyrics.split("\n");
    }
}
