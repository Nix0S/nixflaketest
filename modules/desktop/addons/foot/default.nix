{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.elements.desktop.addons.foot;
in
{
  options.elements.desktop.addons.foot = with types; {
    enable = mkBoolOpt false "Whether to enable the gnome file manager.";
  };

  config = mkIf cfg.enable {
    elements.desktop.addons.term = {
      enable = true;
      pkg = pkgs.foot;
    };

    elements.home.configFile."foot/foot.ini".source = ./foot.ini;
  };
}
