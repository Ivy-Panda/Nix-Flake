{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    impermanence.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, impermanence, home-manager, ... }:

  let

    defaultModules = [
      ./configuration.nix
      ./modules/vim.nix
      ./modules/tmux.nix
      ./modules/packages.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.ivy = import ./home.nix;
      }
    ];

  in {

    nixosConfigurations = {
      pandatop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = defaultModules ++ [];
      };
    };
  };
}
