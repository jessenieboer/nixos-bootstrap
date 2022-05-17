{
  description = "A flake that helps you get started flakifying your configs";

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
          modules = [
            ({ config, pkgs, ... }: {

              imports =[
                ./hardware-configuration.nix
              ];

              config = {
                
                boot.loader = {
                  systemd-boot.enable = true;
                  efi.canTouchEfiVariables = true;
                };

                environment.systemPackages = with pkgs; [ git ]; 
                
                networking = {
                  useDHCP = false;
                  interfaces.eth0.useDHCP = true;
                };  
                
                nix = {
                  package = pkgs.nixFlakes;
                  extraOptions = ''
                    experimental-features = nix-command flakes
                  '';
                };

                system.stateVersion = "21.11";
                
              };
            })
          ];
        };
      };
    };
}
      
