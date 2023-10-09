{
  description = "NixOS configuration for Proxmox";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    # The unfree instance
    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Optionally, pull pre-built binaries from this project's cache
    disko = {
      url = "github:nix-community/disko/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  nixConfig ={
    extra-substituters = [ "https://numtide.cachix.org" ];
    extra-trusted-public-keys = [ "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE=" ];
  };

  outputs = { self, nixpkgs, disko, nixpkgs-unfree, ... }: {
    apps.x86_64-linux.disko = {
      type = "app";
      program = "${disko.packages.x86_64-linux.disko}/bin/disko";
    };
    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit nixpkgs-unfree };
        system = "x86_64-linux";
        modules = [
          ./modules/tailscale.nix
          ./modules/openssh.nix
          ./modules/qemu-guest-agent.nix
          ./modules/ffmpeg.nix
          #./modules/syncthing.nix
          ./modules/samba.nix
          ./modules/surrealdb.nix
          ./modules/disko.nix
          ./hardware.nix
          disko.nixosModules.disko
        ];
      };
    };
  };
}
