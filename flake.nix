{
  description = ''
    For questions just DM me on X: https://twitter.com/@m3tam3re
    There is also some NIXOS content on my YT channel: https://www.youtube.com/@m3tam3re

    One of the best ways to learn NIXOS is to read other peoples configurations. I have personally learned a lot from Gabriel Fontes configs:
    https://github.com/Misterio77/nix-starter-configs
    https://github.com/Misterio77/nix-config

    Please also check out the starter configs mentioned above.
  '';

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-9e9486b.url = "github:nixos/nixpkgs/9e9486ba0142e24a6be35a12384a42982c65d963";
    nixpkgs-locked.url = "github:nixos/nixpkgs/2744d988fa116fc6d46cdfa3d1c936d0abd7d121";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    agenix.url = "github:ryantm/agenix";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";

    dotfiles = {
      url = "git+https://code.m3tam3re.com/m3tam3re/dotfiles.git";
      flake = false;
    };
  };

  outputs = {
    self,
    agenix,
    dotfiles,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages =
      forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    overlays = import ./overlays {inherit inputs outputs;};
    homeManagerModules = import ./modules/home-manager;
    nixosConfigurations = {
      m3-ares = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          hostname = "m3-ares";
        };
        modules = [
          ./hosts/m3-ares
          agenix.nixosModules.default
        ];
      };
      m3-atlas = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        system = "x86_64-linux";
        modules = [
          ./hosts/m3-atlas
          inputs.disko.nixosModules.disko
          agenix.nixosModules.default
        ];
      };
      m3-kratos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          hostname = "m3-kratos";
        };
        modules = [
          ./hosts/m3-kratos
          agenix.nixosModules.default
        ];
      };
      m3-helios = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        system = "x86_64-linux";
        modules = [
          ./hosts/m3-helios
          inputs.disko.nixosModules.disko
          agenix.nixosModules.default
        ];
      };
    };
    homeConfigurations = {
      "m3tam3re@m3-ares" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {
          inherit inputs outputs;
          hostname = "m3-ares";
        };
        modules = [./home/m3tam3re/m3tam3re-ares.nix];
      };
    };
  };
}
