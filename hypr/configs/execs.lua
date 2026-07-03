hl.on("hyprland.start", function () 
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("noctalia")
end)
