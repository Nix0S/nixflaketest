{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let cfg = config.elements.services.printing;
in
{
  options.elements.services.printing = with types; {
    enable = mkBoolOpt false "Whether or not to configure printing support.";
  };

  config = mkIf cfg.enable { services.printing.enable = true; };
}
