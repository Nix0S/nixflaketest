{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let
  cfg = config.elements.tools.at;
in
{
  options.elements.tools.at = with types; {
    enable = mkBoolOpt false "Whether or not to install at.";
    pkg = mkOpt package pkgs.elements.at "The package to install as at.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.pkg
    ];
  };
}
