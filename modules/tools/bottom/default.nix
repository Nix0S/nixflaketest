{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.elements.tools.bottom;
in
{
  options.elements.tools.bottom = with types; {
    enable = mkBoolOpt false "Whether or not to enable Bottom.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bottom
    ];
  };
}
