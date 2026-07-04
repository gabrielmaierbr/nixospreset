# modules/hyprland-lua.nix
#
# Gera os arquivos de configuração Lua do Hyprland (~/.config/hypr/)
# a partir do Nix. O conteúdo Lua vive AQUI DENTRO — este arquivo é a
# fonte da verdade. Para mudar qualquer coisa (keybinds, animações,
# monitor, etc), edite as strings abaixo e rode o rebuild.
#
# Import no home.nix:
#   imports = [ ./modules/hyprland-lua.nix ];
#
# EXCEÇÃO — noctalia.lua:
# Esse arquivo é reescrito automaticamente pelo Noctalia sempre que
# você troca de wallpaper/paleta de cores (igual o starship.toml).
# Por isso ele NÃO é gerenciado como os demais (que são symlinks
# read-only para o Nix store) — em vez disso, usamos home.activation
# para criá-lo apenas UMA VEZ, na ausência do arquivo. Depois disso,
# o Noctalia passa a ser o dono desse arquivo específico.

{ config, pkgs, ... }:
{
  # ============================================================
  # ARQUIVOS ESTÁTICOS — gerenciados 100% pelo Nix (read-only)
  # ============================================================

  xdg.configFile."hypr/hyprland.lua".text = ''
    require("configs/execs")
    require("configs/monitor")
    require("configs/decorations")
    require("configs/animations")
    require("configs/misc")
    require("configs/keybinds")
    require("configs/env")
    require("configs/input")
    require("configs/rules")

    require("noctalia").apply_theme()
  '';

  xdg.configFile."hypr/configs/execs.lua".text = ''
    hl.on("hyprland.start", function ()
        hl.exec_cmd("noctalia")
    end)
  '';

  xdg.configFile."hypr/configs/monitor.lua".text = ''
    hl.monitor({
        output   = "",
        mode     = "2560x1440@180",
        position = "0x0",
        scale    = 1,
        bitdepth = 10,
        cm = "dcip3",
        supports_hdr = -1,
    })
  '';

  xdg.configFile."hypr/configs/decorations.lua".text = ''
    hl.config({
        general = {
            gaps_in  = 2,
            gaps_out = 4,

            border_size = 1,
            allow_tearing = false,

            layout = "dwindle",
        },

        decoration = {
            rounding       = 6,
            rounding_power = 2,

            active_opacity   = 1.0,
            inactive_opacity = 0.9,

            shadow = {
                enabled      = true,
                range        = 4,
                render_power = 3,
                color        = 0xee1a1a1a,
            },

            blur = {
                enabled   = true,
                size      = 3,
                passes    = 4,
                vibrancy  = 0.1696,
            },
        },

        animations = {
            enabled = true,
        },
    })
  '';

  xdg.configFile."hypr/configs/animations.lua".text = ''
    hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })

    hl.curve("specialWorkSwitch", { type = "bezier", points = { {0.05, 0.7}, {0.1, 1}    } })
    hl.curve("emphasizedAccel",   { type = "bezier", points = { {0.3, 0},    {0.8, 0.15} } })
    hl.curve("emphasizedDecel",   { type = "bezier", points = { {0.05, 0.7}, {0.1, 1}    } })
    hl.curve("standard",          { type = "bezier", points = { {0.2, 0},    {0, 1}      } })

    hl.animation({ leaf = "layersIn",         enabled = true, speed = 5, bezier = "emphasizedDecel",   style = "slide" })
    hl.animation({ leaf = "layersOut",        enabled = true, speed = 4, bezier = "emphasizedAccel",   style = "slide" })
    hl.animation({ leaf = "fadeLayers",       enabled = true, speed = 5, bezier = "standard" })

    hl.animation({ leaf = "windowsIn",        enabled = true, speed = 5, bezier = "emphasizedDecel" })
    hl.animation({ leaf = "windowsOut",       enabled = true, speed = 3, bezier = "emphasizedAccel" })
    hl.animation({ leaf = "windowsMove",      enabled = true, speed = 6, bezier = "standard" })
    hl.animation({ leaf = "workspaces",       enabled = true, speed = 5, bezier = "standard" })

    hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "specialWorkSwitch", style = "slidefadevert 15%" })

    hl.animation({ leaf = "fade",             enabled = true, speed = 6, bezier = "standard" })
    hl.animation({ leaf = "fadeDim",          enabled = true, speed = 6, bezier = "standard" })
    hl.animation({ leaf = "border",           enabled = true, speed = 6, bezier = "standard" })


    hl.config({
        dwindle = {
            preserve_split = true,
        },
        master = {
            new_status = "master",
        },
        scrolling = {
            fullscreen_on_one_column = true,
        },
    })
  '';

  xdg.configFile."hypr/configs/misc.lua".text = ''
    hl.config({
        misc = {
            force_default_wallpaper = 0,
            disable_hyprland_logo   = true,
            animate_manual_resizes = false,
            animate_mouse_windowdragging = false,
            allow_session_lock_restore = true,
            middle_click_paste = false,
            focus_on_activate = true,
        },
    })
  '';

  xdg.configFile."hypr/configs/keybinds.lua".text = ''
    local win           = "SUPER"
    local terminal      = "kitty"
    local fileManager   = "nautilus --new-window"
    local browser       = "brave"
    local communication = "discord"
    local music         = "spotify"
    local games         = "steam"
    local coder         = "code"
    local launcher      = "noctalia msg panel-toggle launcher"
    local controlcenter = "noctalia msg panel-toggle control-center"
    local sessionMenu   = "noctalia msg panel-toggle session"
    local lock          = "noctalia msg session lock"
    local screenshot    = "noctalia msg screenshot-region"

    hl.bind(win .. " + Q", hl.dsp.window.close())
    hl.bind(win .. " + W", hl.dsp.exec_cmd(browser))
    hl.bind(win .. " + E", hl.dsp.exec_cmd(fileManager))
    hl.bind(win .. " + T", hl.dsp.exec_cmd(terminal))
    hl.bind(win .. " + S", hl.dsp.exec_cmd(music))
    hl.bind(win .. " + SHIFT + S", hl.dsp.exec_cmd(screenshot))
    hl.bind(win .. " + D", hl.dsp.exec_cmd(communication))
    hl.bind(win .. " + F", hl.dsp.window.fullscreen({mode = "fullscreen", action = "toggle"}))
    hl.bind(win .. " + G", hl.dsp.exec_cmd(games))
    hl.bind(win .. " + Z", hl.dsp.window.float({ action = "toggle" }))
    hl.bind(win .. " + C", hl.dsp.exec_cmd(coder))
    hl.bind(win .. " + SPACE", hl.dsp.exec_cmd(launcher))
    hl.bind(win .. " + P", hl.dsp.exec_cmd(controlcenter))
    hl.bind(win .. " + L", hl.dsp.exec_cmd(lock))
    hl.bind(win .. " + Escape", hl.dsp.exec_cmd(sessionMenu))

    hl.bind(win .. " + left",  hl.dsp.focus({ direction = "left" }))
    hl.bind(win .. " + right", hl.dsp.focus({ direction = "right" }))
    hl.bind(win .. " + up",    hl.dsp.focus({ direction = "up" }))
    hl.bind(win .. " + down",  hl.dsp.focus({ direction = "down" }))

    for i = 1, 10 do
        local key = i % 10
        hl.bind(win .. " + " .. key,             hl.dsp.focus({ workspace = i}))
        hl.bind(win .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
    end

    hl.bind(win .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(win .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

    hl.bind(win .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind(win .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
  '';

  xdg.configFile."hypr/configs/env.lua".text = ''
    local cursorTheme = "Bibata-Original-Classic"
    local cursorSize = "24"

    hl.env("XCURSOR_SIZE", cursorSize)
    hl.env("XCURSOR_THEME", cursorTheme)

    hl.env("HYPRCURSOR_SIZE", "24")

    hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
    hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
    hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

    hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
    hl.env("XDG_SESSION_TYPE", "wayland")
    hl.env("XDG_SESSION_DESKTOP", "Hyprland")

    hl.env("WLR_RENDERER_ALLOW_SOFTWARE","1")
    hl.env("LIBGL_ALWAYS_SOFTWARE","1")
  '';

  xdg.configFile."hypr/configs/input.lua".text = ''
    hl.config({
        input = {
            kb_layout  = "us",
            kb_variant = "intl",
            repeat_delay = 250,
            repeat_rate = 35,
            follow_mouse = 1,

            sensitivity = 0,
            accel_profile = "flat",

            touchpad = {
                natural_scroll = false,
            },
        },
        cursor = {
            hotspot_padding = 1,
            no_warps = true,
        },
    })
  '';

  xdg.configFile."hypr/configs/rules.lua".text = ''
    hl.window_rule({
        name  = "suppress-maximize-events",
        match = { class = ".*" },

        suppress_event = "maximize",
    })

    hl.window_rule({
       name  = "fix-xwayland-drags",
        match = {
            class      = "^$",
            title      = "^$",
            xwayland   = true,
            float      = true,
            fullscreen = false,
            pin        = false,
        },

        no_focus = true,
    })

    hl.window_rule({
        match = { title = "Lista de amigos"},
        float = true,
    })

    hl.window_rule({
        match = { title = "Steam"},
        idle_inhibit = "focus",
    })

    hl.window_rule({
        match = { class = "steam_app_(default|[0-9]+)" },
        idle_inhibit = "always",
        opaque = true,
        no_blur = false,
    })

    hl.window_rule({
        match = { class = "kitty" },
        idle_inhibit = "focus",
        float = true,
        no_blur = true,
        opacity = "0.85"
    })

    hl.window_rule({
        match = { title = "Stremio - Freedom to Stream" },
        idle_inhibit = "always",
        no_blur = false,
    })
  '';

  xdg.configFile."hypr/configs/gestures.lua".text = ''
    hl.gesture({
        fingers = 3,
        direction = "horizontal",
        action = "workspace"
    })
  '';

  # ============================================================
  # noctalia.lua — NÃO gerenciado como os demais.
  # Criado apenas se ainda não existir; depois disso o Noctalia
  # assume a escrita desse arquivo (troca de wallpaper/paleta).
  # ============================================================
  home.activation.criarNoctaliaLua = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    NOCTALIA_LUA="$HOME/.config/hypr/noctalia.lua"
    if [ ! -f "$NOCTALIA_LUA" ]; then
      mkdir -p "$HOME/.config/hypr"
      cat > "$NOCTALIA_LUA" << 'EOF'
-- Generated by Noctalia

local primary = "rgb(ffb4ab)"
local surface = "rgb(1b1110)"
local secondary = "rgb(fdb4ac)"
local error = "rgb(ffb4ab)"

local function apply_theme()
    hl.config({
        general = {
            col = {
                active_border = primary,
                inactive_border = surface,
            },
        },

        group = {
            col = {
                border_active = secondary,
                border_inactive = surface,
                border_locked_active = error,
                border_locked_inactive = surface,
            },

            groupbar = {
                col = {
                    active = secondary,
                    inactive = surface,
                    locked_active = error,
                    locked_inactive = surface,
                },
            },
        },
    })
end

return {
    colors = {
        primary = primary,
        surface = surface,
        secondary = secondary,
        error = error,
    },
    apply_theme = apply_theme
}
EOF
    fi
  '';
}
