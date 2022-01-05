{ config, pkgs, ... }:
{
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;

    config = {
    };

    script = ''
      killall -q polybar
      while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

      polybar main &
    '';
  };
}
