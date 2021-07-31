# minimal configuration.nix for using flakes to manage the rest of configuration
{ config, pkgs, ... }: {

  imports =[
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
	  git
	];

  networking = {
    useDHCP = false;
    interfaces.eth0.useDHCP = true;
  };  
  
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.stateVersion = 21.05;
}
