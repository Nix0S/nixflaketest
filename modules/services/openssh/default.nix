{ options, config, pkgs, lib, systems, name, format, inputs, ... }:

with lib;
with lib.internal;
let
  cfg = config.elements.services.openssh;

  user = config.users.users.${config.elements.user.name};
  user-id = builtins.toString user.uid;

  default-key =
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbBnysAlcJ8+IluAmphZm0zB8BPgmxwrlrcMUkU3A0IPecr0jiu2qZZVymoVRK5z2U/XpoPxtxFH/gZExClP8hMT3WxbQspVBes8/VzHIiuyRjQD9uxCKDC59cWkO8SMvdlGvbUv8yV7aEpm0SN/GeISbrBaT8mOGbAChmxy0N9w29RuccZ9oYHJGbNHDxNk1Rfhq2WirZudKwC8TmwUl844h4ujLFWiAZTNGMC27d7+g6kWVC80NSiWYF9EPPcOVlwczaItusQqSME7mCKSig8ja/UnLykbtNeBtDcWWWBJfa/g3RfvAsJ4Yz2lQhQ3enA9XpJ6rHwFjIj2mmaAgv hydrogen";

  other-hosts = lib.filterAttrs
    (key: host:
      key != name && (host.config.elements.user.name or null) != null)
    ((inputs.self.nixosConfigurations or { }) // (inputs.self.darwinConfigurations or { }));

  other-hosts-config = lib.concatMapStringsSep
    "\n"
    (name:
      let
        remote = other-hosts.${name};
        remote-user-name = remote.config.elements.user.name;
        remote-user-id = builtins.toString remote.config.users.users.${remote-user-name}.uid;

        forward-gpg = optionalString (config.programs.gnupg.agent.enable && remote.config.programs.gnupg.agent.enable)
          ''
            RemoteForward /run/user/${remote-user-id}/gnupg/S.gpg-agent /run/user/${user-id}/gnupg/S.gpg-agent.extra
            RemoteForward /run/user/${remote-user-id}/gnupg/S.gpg-agent.ssh /run/user/${user-id}/gnupg/S.gpg-agent.ssh
          '';

      in
      ''
        Host ${name}
          User ${remote-user-name}
          ForwardAgent yes
          Port ${builtins.toString cfg.port}
          ${forward-gpg}
      ''
    )
    (builtins.attrNames other-hosts);
in
{
  options.elements.services.openssh = with types; {
    enable = mkBoolOpt false "Whether or not to configure OpenSSH support.";
    authorizedKeys =
      mkOpt (listOf str) [ default-key ] "The public keys to apply.";
    port = mkOpt port 2222 "The port to listen on (in addition to 22).";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = if format == "install-iso" then "yes" else "no";

      extraConfig = ''
        StreamLocalBindUnlink yes
      '';

      ports = [
        22
        cfg.port
      ];
    };

    programs.ssh.extraConfig = ''
      Host *
        HostKeyAlgorithms +ssh-rsa

      ${other-hosts-config}
    '';

    elements.user.extraOptions.openssh.authorizedKeys.keys =
      cfg.authorizedKeys;

    elements.home.extraOptions = {
      programs.zsh.shellAliases = foldl
        (aliases: system:
          aliases // {
            "ssh-${system}" = "ssh ${system} -t tmux a";
          })
        { }
        (builtins.attrNames other-hosts);
    };
  };
}
