{ lib, config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fonts.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;


  nix = {
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
    package = pkgs.nixFlakes;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  networking = {
    hostName = "lambda"; # Define your hostname.
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    useDHCP = false;
    interfaces.enp2s0.useDHCP = true;
  };

  time.timeZone = "Asia/Kolkata";



  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "eurosign:e";
      autorun = false;
      exportConfiguration = true;
      #        desktopManager.default = "none";
      displayManager = {
        defaultSession = "none+bspwm";
        startx.enable = true;
      };
      windowManager.bspwm.enable = true;
      desktopManager.xterm.enable = false;
      videoDrivers = [ "intel" ];
      deviceSection = ''
        Option "DRI" "2"
        Option "TearFree" "true"
      '';
    };
    printing.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.makeBinPath [pkgs.greetd.tuigreet] }/tuigreet --time --cmd startx";
          user = "naruto";
        };
      };
    };
  };

  security.rtkit.enable = true;
  sound.enable = true;
  hardware = {
    cpu.intel.updateMicrocode = true;
    pulseaudio = {
      enable = false;
    };
    opengl = {
      driSupport = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  users.users.naruto = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    killall
    coreutils
    vim
  ];

  programs.bash.enableCompletion = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  #### DANGER ZONE ####
  system.stateVersion = "21.05"; # Never ever change this ducks.

}

