{ options, config, lib, ... }:

with lib;
with lib.internal;
let cfg = config.elements.system.xkb;
in
{
  options.elements.system.xkb = with types; {
    enable = mkBoolOpt false "Whether or not to configure xkb.";
  };

  config = mkIf cfg.enable {
    console.useXkbConfig = true;
    services.xserver = {
      layout = "us";
      xkbOptions = "caps:escape";
    };
  };
}
