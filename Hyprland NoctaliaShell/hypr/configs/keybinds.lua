local win           = "SUPER"
local terminal      = "kitty"
local fileManager   = "nautilus --new-window"
local browser       = "brave"
local communication = "discord"
local music         = "spotify"
local games         = "steam"
local coder         = "code"
local launcher      = "noctalia-shell ipc call launcher toggle"
local controlcenter = "noctalia-shell ipc call controlCenter toggle"
local sessionMenu   = "noctalia-shell ipc call sessionMenu toggle"
local lock          = "noctalia-shell ipc call sessionMenu lock"
local notif         = "noctalia-shell ipc call notifications toggleHistory"
local cliphist      = "noctalia-shell ipc call plugin:clipper toggle"
local screenshot    = "noctalia-shell ipc call plugin:screenshot takeScreenshot region"

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
hl.bind(win .. " + V", hl.dsp.exec_cmd(cliphist))
hl.bind(win .. " + N", hl.dsp.exec_cmd(notif))
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