pragma ComponentBehavior: Bound
pragma Singleton

import Quickshell
import Quickshell.Io

FileView {
    id: root

    signal changeSelectedImage(path: url)
    readonly property JsonAdapter jsonAdapter: adapter

    onChangeSelectedImage: path => {
        adapter.wallpaper = path;
        writeAdapter();
    }

    path: `${Quickshell.shellDir}/.wallpaper.json`

    JsonAdapter {
        id: adapter
        property url wallpaper: root.selectedImage
    }
}
