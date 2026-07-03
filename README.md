Copiar "hypr" para ~/.config

Copiar o restante para /etc/nixos

cd /etc/nixos

sudo nixos-rebuild switch --flake .#nixos --extra-experimental-features 'nix-command flakes'
