{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.elements.desktop.addons.keyring;
in
{
  options.elements.desktop.addons.keyring = with types; {
    enable = mkBoolOpt false "Whether to enable the gnome keyring.";
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;

    environment.systemPackages = with pkgs; [ gnome.seahorse ];
  };
}
