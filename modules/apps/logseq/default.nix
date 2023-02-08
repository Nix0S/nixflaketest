{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.elements.apps.logseq;
in
{
  options.elements.apps.logseq = with types; {
    enable = mkBoolOpt false "Whether or not to enable logseq.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ logseq ]; };
}
