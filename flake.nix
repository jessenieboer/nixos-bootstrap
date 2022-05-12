{
  description = "A minimal flake that helps you get started flakifying your configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        minimal = lib.nixosSystem {
                              inherit system;
                              modules = [ ./configuration.nix ];
                            };
      };
    };
}
      
