{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.elements.tools.nix-ld;
in
{
  options.elements.tools.nix-ld = with types; {
    enable = mkBoolOpt false "Whether or not to enable nix-ld.";
  };

  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
  };
}
