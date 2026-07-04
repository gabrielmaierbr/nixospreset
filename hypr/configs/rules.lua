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