final: prev: {
  minecraft = prev.callPackage ./mc.nix { };

  alacritty-ligatures = prev.callPackage ./alacritty-ligatures.nix { };
}
