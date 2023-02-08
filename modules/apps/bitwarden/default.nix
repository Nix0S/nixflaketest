{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.elements.apps.bitwarden;
in
{
  options.elements.apps.bitwarden = with types; {
    enable = mkBoolOpt false "Whether or not to enable Element.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ bitwarden ];
  };
}
