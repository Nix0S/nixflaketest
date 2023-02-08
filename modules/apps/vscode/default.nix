{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.elements.apps.vscode;
in
{
  options.elements.apps.vscode = with types; {
    enable = mkBoolOpt false "Whether or not to enable vscode.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ vscode ]; };
}
