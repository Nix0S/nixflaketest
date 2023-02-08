{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.elements.desktop.addons.waybar;
in
{
  options.elements.desktop.addons.waybar = with types; {
    enable =
      mkBoolOpt false "Whether to enable Waybar in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ waybar ];

    elements.home.configFile."waybar/config".source = ./config;
    elements.home.configFile."waybar/style.css".source = ./style.css;
  };
}
