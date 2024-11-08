# see https://wiki.nixos.org/wiki/Podman

{ config, pkgs, userSettings, ...}:

{
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = [ "podman" ];
  };
}