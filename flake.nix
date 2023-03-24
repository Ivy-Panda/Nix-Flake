{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {

    nixosConfigurations.pandatop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ivy = import ./home.nix;
        }
        
        ./configuration.nix
        ./modules/vim.nix
        ./modules/tmux.nix
        ./modules/packages.nix
      ];
    };
  };
}
