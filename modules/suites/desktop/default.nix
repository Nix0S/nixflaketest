{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.elements.suites.desktop;
in
{
  options.elements.suites.desktop = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    elements = {
      desktop = {
        gnome = enabled;

        addons = { wallpapers = enabled; };
      };

      apps = {
        firefox = enabled;
        bitwarden = enabled;
        vlc = enabled;
        logseq = enabled;
        gparted = enabled;
        gimp = enabled;
        inkscape = enabled;
        vscode = enabled;
      };
    };
  };
}
