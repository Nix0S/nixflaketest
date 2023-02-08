{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.elements.tools.direnv;
in
{
  options.elements.tools.direnv = with types; {
    enable = mkBoolOpt false "Whether or not to enable direnv.";
  };

  config = mkIf cfg.enable {
    elements.home.extraOptions = {
      programs.direnv = {
        enable = true;
        nix-direnv = enabled;
      };
    };
  };
}
