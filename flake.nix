{
  description = "Nixos config flake";

  inputs = {
#     hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
    let
      systemSettings = {
      };

      userSettings = {
      };
    in {
      homeConfigurations = {
        
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./profiles/personal/home.nix
          ];

          extraSpecialArgs = {
            inherit inputs;
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };

      nixosConfigurations = {

        system = nixpkgs.lib.nixosSystem {
          specialArgs = { 
            inherit inputs;
            inherit systemSettings;
            inherit userSettings;
          };

          modules = [
            ./profiles/personal/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
