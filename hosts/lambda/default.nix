{ lib, config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./fonts.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.pathsToLink = [ "/share/zsh" ];
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
      options = "--delete-older-than 1d";
    };
  };
  nixpkgs.config = { allowUnfree = true; };
  networking = {
    hostName = "lambda"; # Define your hostname.
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    useDHCP = false;
    interfaces.enp2s0.useDHCP = true;
    firewall.allowedTCPPorts = [ 57621 80 443 ];
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
        autoLogin.enable = true;
        autoLogin.user = "naruto";
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
          command = "${
              lib.makeBinPath [ pkgs.greetd.tuigreet ]
            }/tuigreet --time --cmd startx";
          user = "naruto";
        };
        initial_session = {
          command = "startx";
          user = "naruto";
        };
      };
    };
  };

  security.rtkit.enable = true;
  sound.enable = true;
  hardware = {
    cpu.intel.updateMicrocode = true;
    pulseaudio = { enable = false; };
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
    xorg.xprop
    wmctrl
  ];

  programs.bash.enableCompletion = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  #### SERVERS ####
  services.nextcloud = {
    enable = true;
    hostName = "nextcloud.tld";
    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname = "nextcloud";
      adminpassFile = "/path/to/admin-pass-file";
      adminuser = "root";
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      { name = "nextcloud";
        ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      }
      { name = "naruto"; }
    ];
    authentication = pkgs.lib.mkOverride 12 ''
      local all all trust
      host all all ::1/128 trust
    '';
  };
    
  environment.persistence."/data" = {
    directories = [
      "/var/lib/postgresql"
    ];
  };
  
  # ensure that postgres is running *before* running the setup
  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };

  #### DANGER ZONE ####
  system.stateVersion = "21.05"; # Never ever change this ducks.

}

