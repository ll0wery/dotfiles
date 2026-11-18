---@diagnostic disable: undefined-global
local mainMod = "SUPER"

hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-flamingo-cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "catppuccin-mocha-flamingo-cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("__GL_VRR_ALLOWED", "0")          
hl.env("__GL_GSYNC_ALLOWED", "0")        

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 15,
        border_size = 2,
        resize_on_border = true,
        layout = "dwindle",
        col = {
            active_border = "rgba(189,147,249,255)", 
            inactive_border = "rgba(68,71,90,255)"
        },
    },
    decoration = {
        rounding = 10,
        active_opacity = 0.95,
        inactive_opacity = 0.75,
        blur = { enabled = false },
        shadow = { enabled = false },
    },
    animations = { 
        enabled = true,
        animation = {
            "windows, 1, 3, default, popin 80%",
            "workspaces, 1, 3, default"
        }
    },
    cursor = { no_hardware_cursors = true },
    input = {
        kb_layout = "us,br",
        kb_options = "grp:alt_shift_toggle",
        follow_mouse = 1,
        sensitivity = 0,
    },
})

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.0 })

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + BackSpace", hl.dsp.window.close())
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("code"))

hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("sh -c '$HOME/.config/rofi/powermenu.sh'"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("sh -c 'grim -g \"$(slurp -d)\" - | wl-copy'"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("sh -c 'cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy'"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("/home/l0wer/.local/bin/change-wallpaper.sh"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("/home/l0wer/.local/bin/screenrecord.sh"))

hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ state = false }))
hl.bind(mainMod .. " + X", hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.workspace.toggle_special("minimized"))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.workspace_rule({ workspace = "special:minimized", gaps_out = 20 })
hl.window_rule({ name = "fullscreen-opaque", match = { fullscreen = true }, opacity = "1.0 1.0" })

hl.on("hyprland.start", function()
    hl.exec_cmd("sleep 1 && waybar")
    hl.exec_cmd("sh -c '$HOME/.local/bin/start-wallpaper.sh'")
    hl.exec_cmd("swaync")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)