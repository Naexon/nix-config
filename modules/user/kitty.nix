{...}:

{

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  programs.kitty = {
    enable = true;
    
    font = {
      name = "JetBrainsMono Nerd Font";
    };

    shellIntegration.enableZshIntegration = true;
    shellIntegration.enableBashIntegration = true;

    settings = {
      # hide_window_decorations = true;
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      window_padding_width = 10;
      background_opacity = "0.7";
      background_blur = 20;
    };
  };
}