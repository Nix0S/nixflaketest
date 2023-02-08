{ lib, pkgs, config, ... }:

let
  inherit (lib) mkIf mkEnableOption;
  inherit (lib.internal) mkOpt;

  cfg = config.elements.security.acme;
in
{
  options.elements.security.acme = with lib.types; {
    enable = mkEnableOption "default ACME configuration";
    email = mkOpt str config.elements.user.email "The email to use.";
  };

  config = mkIf cfg.enable {
    security.acme = {
      acceptTerms = true;

      defaults = {
        inherit (cfg) email;
      };
    };
  };
}
