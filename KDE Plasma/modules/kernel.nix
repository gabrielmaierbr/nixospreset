{ config, pkgs, ... }:
{
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.initrd.kernelModules = [ "amdgpu" ];
}
