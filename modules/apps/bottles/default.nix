{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.elements.apps.bottles;
in
{
  options.elements.apps.bottles = with types; {
    enable = mkBoolOpt false "Whether or not to enable Bottles.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ bottles ]; };
}
