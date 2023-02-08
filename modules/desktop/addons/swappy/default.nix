{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.elements.desktop.addons.swappy;
in
{
  options.elements.desktop.addons.swappy = with types; {
    enable =
      mkBoolOpt false "Whether to enable Swappy in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ swappy ];

    elements.home.configFile."swappy/config".source = ./config;
    elements.home.file."Pictures/screenshots/.keep".text = "";
  };
}
