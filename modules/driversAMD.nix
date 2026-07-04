{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.amdgpu.initrd.enable = true;

  hardware.cpu.amd.updateMicrocode = true;

  hardware.amdgpu.opencl.enable = true;

  services.lact.enable = true;
}