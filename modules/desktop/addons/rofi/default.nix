{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.elements.desktop.addons.rofi;
in
{
  options.elements.desktop.addons.rofi = with types; {
    enable =
      mkBoolOpt false "Whether to enable Rofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ rofi ];

    elements.home.configFile."rofi/config.rasi".source = ./config.rasi;
  };
}
