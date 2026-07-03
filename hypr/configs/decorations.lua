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