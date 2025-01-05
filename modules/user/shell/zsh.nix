{ config, pkgs, systemSettings, userSettings, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      # you cannot use sudo here
      switch = "nh os switch -H ${systemSettings.profile} ${userSettings.repoDirectory}";
      switch-update = "nh os switch -u -H ${systemSettings.profile} ${userSettings.repoDirectory}";
      update = "nix flake update ${userSettings.repoDirectory}";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "kubectl" "rust" ];
    };
  };

  programs.kitty = {
    shellIntegration.enableZshIntegration = true;
  };
}