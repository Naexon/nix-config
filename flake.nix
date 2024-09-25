{
  description = "Nixos config flake";

  inputs = {
#     hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, ... }@inputs: 
    let
      systemSettings = {
        system = "x86_64-linux";
        hostname = "thinkpad";
        profile = "personal";

        unstable = true;
      };

      userSettings = {
        username = "alex";
        name = "Alex";
        email = "naexoncode@pm.me";
        homeDirectory = "/home/alex";
        repoDirectory = "/home/alex/nix-config";
      };

      nixpkgs = (if systemSettings.unstable then inputs.nixpkgs-unstable else inputs.nixpkgs-stable);

      pkgs = import nixpkgs {
        system = systemSettings.system;

        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      home-manager = (if systemSettings.unstable then inputs.home-manager-unstable else inputs.home-manager-stable);

      lib = (if systemSettings.unstable then inputs.nixpkgs-unstable.lib else inputs.nixpkgs-stable.lib);
    in {
      # homeConfigurations = {

      #   default = home-manager.lib.homeManagerConfiguration {
      #     inherit pkgs;

      #     modules = [
      #       (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
      #       home-manager.nixosModules.home-manager {
      #         home-manager.useGlobalPkgs = true;
      #         home-manager.useUserPackages = true;
      #         home-manager.users.${userSettings.username} = import ./home.nix;
      #       }
      #     ];

      #     extraSpecialArgs = {
      #       inherit inputs;
      #       inherit systemSettings;
      #       inherit userSettings;
      #     };
      #   };
      # };

      nixosConfigurations = {

        ${systemSettings.profile} = lib.nixosSystem {
          specialArgs = { 
            inherit inputs;
            inherit home-manager;
            inherit systemSettings;
            inherit userSettings;
          };

          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
            home-manager.nixosModules.default {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userSettings.username} = import (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix");
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit systemSettings;
                inherit userSettings;
              };
            }
          ];
        };
      };
    };
}
