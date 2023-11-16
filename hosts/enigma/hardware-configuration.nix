{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/d955412b-87f0-46ca-9659-ecc0cd3d95a8";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-7ab31577-5ef4-45da-8fd6-cb49fd9e3d96".device = "/dev/disk/by-uuid/7ab31577-5ef4-45da-8fd6-cb49fd9e3d96";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/4B56-CEDF";
      fsType = "vfat";
    };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
