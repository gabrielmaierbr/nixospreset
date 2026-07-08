{ config, pkgs, ... }:
{
    services.flatpak = {
        enable = true;
        packages = [
            #"net.waterfox.waterfox"
            "org.onlyoffice.desktopeditors"
        ];
    };
}
