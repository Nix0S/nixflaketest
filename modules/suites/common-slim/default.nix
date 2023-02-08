{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.elements.suites.common-slim;
in
{
  options.elements.suites.common-slim = with types; {
    enable = mkBoolOpt false "Whether or not to enable common-slim configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.elements.list-iommu
    ];

    elements = {
      nix = enabled;

      cli-apps = {
        flake = enabled;
      };

      tools = {
        fup-repl = enabled;
        comma = enabled;
        bottom = enabled;
        direnv = enabled;
      };

      hardware = {
        storage = enabled;
        networking = enabled;
      };

      services = {
        openssh = enabled;
        tailscale = enabled;
      };

      security = {
        doas = enabled;
      };

      system = {
        boot = enabled;
        fonts = enabled;
        locale = enabled;
        time = enabled;
        xkb = enabled;
      };
    };
  };
}
