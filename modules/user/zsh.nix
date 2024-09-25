{ config, pkgs, systemSettings, userSettings, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      switch = "sudo nixos-rebuild switch --flake ${userSettings.repoDirectory}#${systemSettings.profile}";
      update = "nix flake update ${userSettings.repoDirectory}";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

  programs.kitty = {
    shellIntegration.enableZshIntegration = true;
  };
}