{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    impermanence.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, impermanence, home-manager, ... }:

  let

    defaultModules = [
      impermanence.nixosModule
      ./configuration.nix
      ./modules/vim.nix
      ./modules/tmux.nix
      ./modules/packages.nix
      ./modules/impermanence.nix

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
        modules = defaultModules ++ [
          ./hosts/pandatop/pandatop.nix
          ./hosts/pandatop/hardware-configuration.nix
          ./modules/sway.nix
          ./modules/graphicalpackages.nix
        ];
      };
      
      pandabutt = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = defaultModules ++ [
          ./hosts/pandabutt/pandabutt.nix
          ./hosts/pandabutt/hardware-configuration.nix
          ./modules/remote-unlock.nix 
        ];
      };
    };
  };
}
