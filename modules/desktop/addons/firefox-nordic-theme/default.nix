{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.elements.desktop.addons.firefox-nordic-theme;
  profileDir = ".mozilla/firefox/${config.elements.user.name}";
in
{
  options.elements.desktop.addons.firefox-nordic-theme = with types; {
    enable = mkBoolOpt false "Whether to enable the Nordic theme for firefox.";
  };

  config = mkIf cfg.enable {
    elements.apps.firefox = {
      extraConfig = builtins.readFile
        "${pkgs.elements.firefox-nordic-theme}/configuration/user.js";
      userChrome = ''
        @import "${pkgs.elements.firefox-nordic-theme}/userChrome.css";
      '';
    };
  };
}
