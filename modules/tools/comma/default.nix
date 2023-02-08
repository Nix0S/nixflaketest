{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.elements.tools.comma;
in
{
  options.elements.tools.comma = with types; {
    enable = mkBoolOpt false "Whether or not to enable comma.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      comma
      elements.nix-update-index
    ];

    elements.home.extraOptions = { programs.nix-index.enable = true; };
  };
}
