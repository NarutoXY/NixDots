# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/dd08b75d-8c82-4e8e-ab45-d444e0d12095";
      fsType = "btrfs";
      options = [ "subvol=nixos" "noatime" "compress=zstd:2" "space_cache=v2" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/d36a0eaf-4d32-44f0-a860-aa2953838ba2";
      fsType = "btrfs";
      options = [ "subvol=home" "noatime" "compress=zstd:2" "space_cache=v2" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7438-C531";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/d0ad940e-8a63-48f5-8169-9bc0b620a830"; }
    ];

}

