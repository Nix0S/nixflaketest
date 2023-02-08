{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.elements.apps.gimp;
in
{
  options.elements.apps.gimp = with types; {
    enable = mkBoolOpt false "Whether or not to enable Gimp.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ gimp ]; };
}
