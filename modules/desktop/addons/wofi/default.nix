{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.elements.desktop.addons.wofi;
in
{
  options.elements.desktop.addons.wofi = with types; {
    enable =
      mkBoolOpt false "Whether to enable the Wofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ wofi wofi-emoji ];

    # config -> .config/wofi/config
    # css -> .config/wofi/style.css
    # colors -> $XDG_CACHE_HOME/wal/colors
    # elements.home.configFile."foot/foot.ini".source = ./foot.ini;
    elements.home.configFile."wofi/config".source = ./config;
    elements.home.configFile."wofi/style.css".source = ./style.css;
  };
}
