Copiar conteúdo da pasta clonada para /etc/nixos

sudo cp -R * /etc/nixos

cd /etc/nixos

sudo nixos-rebuild switch --flake .#nixos


Update noctalia:

cd /etc/nixos

sudo nix flake lock --update-input noctalia

sudo nixos-rebuild switch --flake .#nixos



Update de tudo:

sudo nix flake update
sudo nixos-rebuild switch --flake .#nixos


Configurar Usuário em home.nix

home.username = "SEU-USER";
home.homeDirectory = "/home/SEU-USER";

Configurar Usuário em /modules/user.nix

Configurar Monitor em /modules/hyprland-nix.lua (onde ele gera o monitor.lua), alterar LarguraXAltura@Hz e bitdepth a depender de quantos bits é a tela

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
