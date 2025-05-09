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

  outputs =
    {
      self,
      agenix,
      dotfiles,
      home-manager,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      users = {
        philipp = "lstr-261";
        eugen = "stcr-s2907";
      };
      hosts = {
        server = "sierpinski-23";
        main-pc = "penrose-512";
        mini-pc = "protektor-controller";
      };
    in
    {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs outputs; };
      homeManagerModules = import ./modules/home-manager;
      nixosConfigurations = {
        sierpinski-23 = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            hostname = "sierpinski-23";
          };
          system = "x86_64-linux";
          modules = [
            ./hosts/sierpinski-23
            inputs.disko.nixosModules.disko
            agenix.nixosModules.default
          ];
        };
        # penrose-512 = nixpkgs.lib.nixosSystem {
        # specialArgs = {
        # inherit inputs outputs;
        # hostname = "penrose-512";
        # };
        # system = "x86_64-linux";
        # modules = [
        # ./hosts/penrose-512
        # inputs.disko.nixosModules.disko
        # agenix.nixosModules.default
        # ];
        # };
      };
      homeConfigurations = {
        "lstr-261@penrose-512" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = {
            inherit inputs outputs;
            hostname = "penrose-512";
          };
          modules = [ ./home/m3tam3re/m3tam3re-ares.nix ];
        };
      };
    };
}
