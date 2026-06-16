import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.Mpris
import Quickshell.Services.SystemTray

ShellRoot {
    readonly property color bg:      "#282a36"
    readonly property color bgAlt:   "#1e1f29"
    readonly property color fg:      "#f8f8f2"
    readonly property color comment: "#6272a4"
    readonly property color green:   "#50fa7b"
    readonly property color purple:  "#bd93f9"
    readonly property color surface: "#44475a"
    readonly property color overlay: "#21222c"

    property var wsList: []

    SystemClock { id: sysClock; enabled: true; precision: SystemClock.Minutes }

    Process { id: cmdProc }

    Process {
        id: getSock
        stdout: StdioCollector { id: sockColl; waitForEnd: true }
        command: ["bash", "-c", "echo -n \"$NIRI_SOCKET\""]
        running: true
        onExited: {
            var path = sockColl.text;
            if (path.length > 0) {
                niriEvents.path = path;
                niriEvents.connected = true;
            }
        }
    }

    Socket {
        id: niriEvents
        parser: SplitParser {
            splitMarker: "\n"
            onRead: onNiriEvent
        }
        onConnectionStateChanged: {
            if (connected) {
                write('"EventStream"\n');
                flush();
            }
        }
    }

    property var wsOcc: ({})

    function onNiriEvent(data) {
        try {
            var msg = JSON.parse(data.trim());
            for (var key in msg) {
                var val = msg[key];
                if (key === "WindowsChanged" && val.windows) {
                    var occ = {};
                    for (var i = 0; i < val.windows.length; i++) {
                        var w = val.windows[i];
                        if (w.workspace_id !== null && w.workspace_id !== undefined)
                            occ[String(w.workspace_id)] = true;
                    }
                    wsOcc = occ;
                    mergeOccupancy();
                } else if (key === "WindowOpenedOrChanged" || key === "WindowClosed") {
                    pollWorkspaces();
                }
            }
        } catch (e) {}
    }

    function mergeOccupancy() {
        var updated = [];
        for (var i = 0; i < wsList.length; i++) {
            var o = wsList[i];
            updated.push({
                id: o.id, name: o.name, focused: o.focused,
                occupied: String(o.id) in wsOcc
            });
        }
        wsList = updated;
    }

    Process {
        id: wsPoller
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: function(data) {
                try {
                    var parsed = JSON.parse(data.trim());
                    if (Array.isArray(parsed)) {
                        var list = [];
                        for (var i = 0; i < parsed.length; i++) {
                            var w = parsed[i];
                            list.push({
                                id: String(w.id),
                                name: w.name || String(w.id),
                                focused: w.is_focused === true,
                                occupied: String(w.id) in wsOcc
                            });
                        }
                        wsList = list;
                    }
                } catch (e) {}
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: pollWorkspaces()
        Component.onCompleted: pollWorkspaces()
    }

    function pollWorkspaces() {
        wsPoller.command = ["niri", "msg", "-j", "workspaces"];
        wsPoller.running = true;
    }

    function focusWorkspace(id) {
        cmdProc.command = ["niri", "msg", "action", "focus-workspace", String(id)];
        cmdProc.running = true;
    }

    function activateAdjacentWorkspace(dir) {
        if (wsList.length === 0) return;
        var idx = -1;
        for (var i = 0; i < wsList.length; i++) {
            if (wsList[i].focused) { idx = i; break; }
        }
        if (idx < 0) idx = dir > 0 ? -1 : wsList.length;
        var next = idx + dir;
        if (next >= 0 && next < wsList.length)
            focusWorkspace(wsList[next].id);
    }

    PanelWindow {
        id: window
        screen: Quickshell.screens.primary
        implicitHeight: 34
        color: "transparent"
        anchors.top: true
        anchors.left: true
        anchors.right: true

        Rectangle {
            anchors.fill: parent
            anchors.margins: 4
            radius: 10
            color: Qt.rgba(0x21/255, 0x22/255, 0x2c/255, 0.92)
            border.color: Qt.rgba(0x44/255, 0x47/255, 0x5a/255, 0.5)
            border.width: 1

            RowLayout {
                id: barRow
                anchors.fill: parent
                anchors.leftMargin: 6
                anchors.rightMargin: 6
                spacing: 4

                // ── Left capsule ──────────────────────────
                Rectangle {
                    id: leftCapsule
                    height: 24
                    radius: 6
                    color: Qt.rgba(bg.r, bg.g, bg.b, 0.5)
                    Layout.alignment: Qt.AlignVCenter
                    implicitWidth: leftContent.width + 8

                    Row {
                        id: leftContent
                        y: (parent.height - implicitHeight) / 2
                        x: 4
                        spacing: 3

                        Text {
                            text: ""
                            color: purple
                            font.pixelSize: 12
                            font.family: "Pragmasevka Nerd Font"
                        }

                        Rectangle {
                            implicitWidth: 1; implicitHeight: 14; color: surface
                        }

                        Row {
                            spacing: 3

                            Repeater {
                                model: wsList
                                delegate: Rectangle {
                                    required property var modelData
                                    readonly property real base: 16
                                    width: modelData.focused ? base * 2.0 : (modelData.occupied ? base * 1.4 : base * 0.9)
                                    height: 18
                                    radius: 5
                                    color: modelData.focused ? purple : (modelData.occupied ? Qt.rgba(surface.r, surface.g, surface.b, 0.7) : "transparent")
                                    border.width: modelData.focused || modelData.occupied ? 0 : 1
                                    border.color: modelData.occupied ? "transparent" : Qt.rgba(fg.r, fg.g, fg.b, 0.25)

                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData.name
                                        color: modelData.focused ? "#1e1f29" : fg
                                        font.pixelSize: 10
                                        font.family: "Pragmasevka Nerd Font"
                                        font.weight: modelData.focused ? Font.DemiBold : Font.Normal
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: focusWorkspace(modelData.id)
                                        onWheel: function(wheel) {
                                            activateAdjacentWorkspace(wheel.angleDelta.y > 0 ? -1 : 1)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Item { Layout.fillWidth: true }

                // ── Media capsule ──────────────────────────
                Rectangle {
                    id: mediaCapsule
                    height: 24
                    radius: 6
                    color: Qt.rgba(bg.r, bg.g, bg.b, 0.5)
                    Layout.alignment: Qt.AlignVCenter
                    visible: Mpris.players.count > 0
                    implicitWidth: mediaContent.width + 8

                    Row {
                        id: mediaContent
                        y: (parent.height - implicitHeight) / 2
                        x: 4
                        spacing: 3

                        Text {
                            property var player: Mpris.players.count > 0 ? Mpris.players[0] : null
                            color: player && player.playbackStatus === "Playing" ? fg : comment
                            font.pixelSize: 10
                            font.family: "Pragmasevka Nerd Font"
                            elide: Text.ElideRight
                            maximumLineCount: 1
                            text: {
                                var p = player;
                                if (!p || !p.trackTitle) return "";
                                return p.trackArtist ? p.trackTitle + " \u2014 " + p.trackArtist : p.trackTitle;
                            }
                        }

                        Text {
                            property var player: Mpris.players.count > 0 ? Mpris.players[0] : null
                            text: player && player.playbackStatus === "Playing" ? "󰏤" : "󰐊"
                            color: green
                            font.pixelSize: 10
                            font.family: "Pragmasevka Nerd Font"
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    var p = Mpris.players[0];
                                    if (p) p.togglePlaying();
                                }
                            }
                        }

                        Text {
                            text: "󰒭"
                            color: comment
                            font.pixelSize: 10
                            font.family: "Pragmasevka Nerd Font"
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    var p = Mpris.players[0];
                                    if (p) p.next();
                                }
                            }
                        }
                    }
                }

                // ── Right capsule ──────────────────────────
                Rectangle {
                    id: rightCapsule
                    height: 24
                    radius: 6
                    color: Qt.rgba(bg.r, bg.g, bg.b, 0.5)
                    Layout.alignment: Qt.AlignVCenter
                    implicitWidth: rightContent.width + 8

                    Row {
                        id: rightContent
                        y: (parent.height - implicitHeight) / 2
                        x: 4
                        spacing: 4

                        Text {
                            color: fg
                            font.pixelSize: 11
                            font.family: "Pragmasevka Nerd Font"
                            font.weight: Font.DemiBold
                            text: {
                                var d = sysClock.date;
                                if (!d) return "";
                                return ("0" + d.getHours()).slice(-2) + ":"
                                     + ("0" + d.getMinutes()).slice(-2);
                            }
                        }

                        Rectangle {
                            implicitWidth: 1; implicitHeight: 14; color: surface
                        }

                        Row {
                            spacing: 2
                            Repeater {
                                model: SystemTray.items
                                delegate: IconImage {
                                    required property var modelData
                                    source: modelData.icon
                                    implicitWidth: 16; implicitHeight: 16
                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: modelData.activate()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
