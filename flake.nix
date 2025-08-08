{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgsUnstable.url = "nixpkgs/nixos-unstable";

    lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.3-1.tar.gz";
    lix-module.inputs.nixpkgs.follows = "nixpkgs";
    
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, lix-module, lanzaboote, impermanence, home-manager, ... }:

  let

    defaultModules = [
      lix-module.nixosModules.default
      lanzaboote.nixosModules.lanzaboote
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
      pandaden = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = defaultModules ++ [
          ./hosts/pandaden/pandaden.nix
          ./hosts/pandaden/hardware-configuration.nix
          ./modules/sway.nix
          # ./modules/nvidia.nix
          ./modules/graphicalpackages.nix
        ];
      };

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
          ./modules/trilium-server.nix
        ];
      };
    };
  };
}
