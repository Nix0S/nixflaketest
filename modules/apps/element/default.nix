{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.elements.apps.element;
in
{
  options.elements.apps.element = with types; {
    enable = mkBoolOpt false "Whether or not to enable Element.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ element-desktop ];
  };
}
