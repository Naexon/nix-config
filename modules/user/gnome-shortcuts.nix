{...}:

{
  # Adding custom gnome keyboard shortcuts
  # See https://discourse.nixos.org/t/nixos-options-to-configure-gnome-keyboard-shortcuts/7275/7
  dconf.settings =
    let
      inherit (builtins) length head tail listToAttrs genList;
      range = a: b: if a < b then [ a ] ++ range (a + 1) b else [ ];
      globalPath = "org/gnome/settings-daemon/plugins/media-keys";
      path = "${globalPath}/custom-keybindings";
      mkPath = id: "${globalPath}/custom${toString id}";
      isEmpty = list: length list == 0;
      mkSettings = settings:
        let
          checkSettings = { name, command, binding }@this: this;
          aux = i: list:
            if isEmpty list then [ ] else
            let
              hd = head list;
              tl = tail list;
              name = mkPath i;
            in
            aux (i + 1) tl ++ [{
              name = mkPath i;
              value = checkSettings hd;
            }];
          settingsList = (aux 0 settings);
        in
        listToAttrs (settingsList ++ [
          {
            name = globalPath;
            value = {
              custom-keybindings = genList (i: "/${mkPath i}/") (length settingsList);
            };
          }
        ]);
    in
    mkSettings [
      {
        name = "open-kitty";
        command = "kitty";
        binding = "<Super>t";
      }
      {
        name = "open-codium";
        command = "codium";
        binding = "<Super>c";
      }
    ];
}

