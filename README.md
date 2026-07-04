Copiar "hypr" para ~/.config

Copiar o restante para /etc/nixos

cd /etc/nixos

sudo nixos-rebuild switch --flake .#nixos --extra-experimental-features 'nix-command flakes'


Update noctalia:

cd /etc/nixos
sudo nix flake lock --update-input noctalia
sudo nixos-rebuild switch --flake .#nixos
