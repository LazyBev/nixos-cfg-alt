hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@120.03",
    position = "0x0",
    scale    = "1",
})

hl.config({
    general = {
        layout = "scrolling",
        gaps_in  = 5,
        gaps_out = 5,
        border_size = 2,
        col = {
            active_border   = "rgba(bd93f9ff)",
            inactive_border = "rgba(44475aff)",
        },
    },
    decoration = {
        rounding       = 0,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,
        blur = {
            enabled = true,
            size = 5,
            passes = 2,
        },
        shadow = { enabled = false },
    },
    input = {
        kb_layout  = "gb",
        kb_options = "numpad:mac",
        touchpad = {
            natural_scroll = true,
            tap_to_click   = true,
        },
    },
    cursor = {
        enable_hyprcursor = false,
    },
    animations = {
        enabled = true,
    },
    dwindle = { preserve_split = true },
    scrolling = {
        direction = "right",
        fullscreen_on_one_column = true,
        column_width = 0.5,
        focus_fit_method = 1,
        follow_focus = true,
        wrap_focus = true,
        wrap_swapcol = true,
        explicit_column_widths = "0.5, 1.0",
    },
})

hl.curve("overshot", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 3, bezier = "overshot", style = "slide"  })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 3, bezier = "overshot", style = "slide"  })
hl.animation({ leaf = "fade",        enabled = true, speed = 3, bezier = "overshot" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 2, bezier = "overshot", style = "slide"  })

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland")
hl.env("GTK_USE_PORTAL", "1")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
hl.env("GTK_THEME", "Dracula")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("XCURSOR_THEME", "catppuccin-mocha-mauve-cursors")
hl.env("XCURSOR_SIZE", "24")

hl.window_rule({
    match = { title = "^Picture-in-Picture$" },
    float = true,
})
hl.window_rule({
    match = { class = "^(pavucontrol)$" },
    float = true,
})
hl.window_rule({
    match = { class = "^(nm-connection-editor)$" },
    float = true,
})
hl.window_rule({
    match = { class = "^(mpv)$" },
    float = true,
    size  = { 640, 360 },
})

hl.on("hyprland.start", function ()
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("dunst")
    hl.exec_cmd("bash -c 'sleep 1 && nm-applet --indicator'")
    hl.exec_cmd("bash -c 'mkfifo /tmp/cava.fifo 2>/dev/null; cava -p ~/.config/waybar/custom_modules/cava/config &'")
    hl.exec_cmd("bash -c 'waybar 2>&1 | grep -v \"No icon name or pixmap given\" &'")
    hl.exec_cmd("bash -c 'killall swaybg awww-daemon 2>/dev/null; awww-daemon &'")
    hl.exec_cmd("bash -c 'sleep 0.5 && awww img --transition-fps 60 --transition-type wipe --transition-duration 2 /home/yari/Pictures/matikanefuku.png'")
end)

local m = "ALT"

hl.bind(m .. " + Return",        hl.dsp.exec_cmd("alacritty"))
hl.bind(m .. " + SHIFT + Return", hl.dsp.exec_cmd("alacritty -e zellij"))
hl.bind(m .. " + D",              hl.dsp.exec_cmd("wmenu-run"))
hl.bind(m .. " + B",              hl.dsp.exec_cmd("qutebrowser"))
hl.bind(m .. " + SHIFT + B",     hl.dsp.exec_cmd("librewolf"))
hl.bind(m .. " + T",              hl.dsp.exec_cmd("alacritty -e yazi"))
hl.bind(m .. " + SHIFT + T",     hl.dsp.exec_cmd("thunar"))
hl.bind(m .. " + E",              hl.dsp.exec_cmd("alacritty -e nvim"))
hl.bind(m .. " + SHIFT + E",     hl.dsp.exec_cmd("vscodium"))
hl.bind(m .. " + S",              hl.dsp.exec_cmd("alacritty -e rmpc"))
hl.bind(m .. " + SHIFT + S",     hl.dsp.exec_cmd("steam"))
hl.bind(m .. " + V",              hl.dsp.exec_cmd("alacritty -e btop"))
hl.bind(m .. " + SHIFT + V",     hl.dsp.exec_cmd("vesktop"))
hl.bind(m .. " + Y",              hl.dsp.exec_cmd("waypaper"))

hl.bind("SUPER + SHIFT + L",      hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + CTRL + P",       hl.dsp.exec_cmd("doas reboot"))
hl.bind("SUPER + SHIFT + P",      hl.dsp.exec_cmd("doas poweroff"))
hl.bind("SUPER + SHIFT + Backspace", hl.dsp.exit())

hl.bind(m .. " + X",        hl.dsp.exec_cmd("bash -c 'grimblast copysave area ~/Pictures/Screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png && notify-send Screenshot \"Area screenshot saved\"'"))
hl.bind(m .. " + SHIFT + X", hl.dsp.exec_cmd("bash -c 'grimblast copysave output ~/Pictures/Screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png && notify-send Screenshot \"Output screenshot saved\"'"))
hl.bind(m .. " + CTRL + X", hl.dsp.exec_cmd("bash -c 'grimblast copysave active ~/Pictures/Screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png && notify-send Screenshot \"Active window screenshot saved\"'"))

hl.bind("CTRL + ALT + Q", hl.dsp.window.close())

hl.bind(m .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(m .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(m .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(m .. " + J", hl.dsp.focus({ direction = "d" }))

hl.bind(m .. " + SHIFT + H", hl.dsp.layout("swapcol l"))
hl.bind(m .. " + SHIFT + L", hl.dsp.layout("swapcol r"))
hl.bind(m .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(m .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

hl.bind(m .. " + Tab",       hl.dsp.window.float({ action = "toggle" }))
hl.bind(m .. " + SHIFT + SPACE", hl.dsp.exec_cmd("hyprctl dispatch focuswindow floating"))
hl.bind(m .. " + CTRL + SPACE", hl.dsp.exec_cmd("hyprctl dispatch focuswindow tiling"))

hl.bind(m .. " + F", function()
    local win = hl.get_active_window()
    if not win then return end
    if win.fullscreen ~= 0 then
        hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen", action = "unset" }))
    else
        hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen", action = "set" }))
    end
end)

hl.bind(m .. " + MINUS",        function() hl.dispatch(hl.dsp.window.resize({ x = -30, y = 0 })) end)
hl.bind(m .. " + EQUAL",        function() hl.dispatch(hl.dsp.window.resize({ x = 30,  y = 0 })) end)
hl.bind(m .. " + SHIFT + MINUS", function() hl.dispatch(hl.dsp.window.resize({ x = 0, y = -30 })) end)
hl.bind(m .. " + SHIFT + EQUAL", function() hl.dispatch(hl.dsp.window.resize({ x = 0, y = 30  })) end)
hl.bind(m .. " + W", function()
    hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
    hl.dispatch(hl.dsp.window.move({ workspace = "+0" }))
    hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
    hl.dispatch(hl.dsp.window.move({ workspace = "special:minimize" }))
    hl.dispatch(hl.dsp.workspace.toggle_special("minimize"))
end)

hl.bind(m .. " + Comma",  hl.dsp.layout("swapwithmaster"))
hl.bind(m .. " + Period", hl.dsp.layout("addtogroup"))

for i = 1, 9 do
    hl.bind(m .. " + " .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(m .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(m .. " + N", hl.dsp.focus({ workspace = "+1" }))
hl.bind(m .. " + M", hl.dsp.focus({ workspace = "-1" }))
hl.bind(m .. " + SHIFT + N", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(m .. " + SHIFT + M", hl.dsp.window.move({ workspace = "-1" }))

hl.bind(m .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true, desc = "Drag floating windows" })
hl.bind(m .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, desc = "Resize floating windows" })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind(m .. " + CTRL + L",     hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind(m .. " + CTRL + H",     hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
