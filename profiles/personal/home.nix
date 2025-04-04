{ config, pkgs, inputs, systemSettings, userSettings, ... }:

# let
#     startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
#       ${pkgs.waybar}/bin/waybar &
#       ${pkgs.swww}/bin/swww init &
  
#       sleep 1
#     '';
# in
{

  imports = [
    ../../modules/user/shell/starship.nix
    ../../modules/user/shell/zsh.nix
    
    ../../modules/user/kitty.nix
    ../../modules/user/gnome-shortcuts.nix
  ];

  # wayland.windowManager.hyprland = {
  #   enable = true;

  #   # plugins = [
  #   #   inputs.hyprland-plugins.packages."${pkgs.system}".borders-plus-plus
  #   # ];

  #   # settings = {
  #   #   exec-once = ''${startupScript}/bin/start'';

  #   #   # "plugin:borders-plus-plus" = {
  #   #   #   add_borders = 1; # 0 - 9

  #   #   #   # you can add up to 9 borders
  #   #   #   "col.border_1" = "rgb(ffffff)";
  #   #   #   "col.border_2" = "rgb(2222ff)";

  #   #   #   # -1 means "default" as in the one defined in general:border_size
  #   #   #   border_size_1 = 10;
  #   #   #   border_size_2 = -1;

  #   #   #   # makes outer edges match rounding of the parent. Turn on / off to better understand. Default = on.
  #   #   #   natural_rounding = "yes";
  #   #   # };
  #   # };
  # };

  home.username = userSettings.username;
  home.homeDirectory = userSettings.homeDirectory;

  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    vim
    nixpkgs-fmt
    htop
    floorp
    vesktop # Discord Client
    vlc
    
    # (nerdfonts.override { fonts = [ "FiraCode" ]; })
    nerd-fonts.jetbrains-mono

    libreoffice-still
    zed-editor

    # vscodium-fhs
    vscode

    anytype
    gnome-tweaks

    nom

    rustup
    gcc_multi

    python3

    steam-run

    zoxide
    jetbrains.pycharm-professional
    openconnect
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
