{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.elements.apps.cadence;
in
{
  options.elements.apps.cadence = with types; {
    enable = mkBoolOpt false "Whether or not to enable Cadence.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ cadence ]; };
}
