{
  description = "NixOS configuration for Proxmox";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    disko = {
      url = "github:nix-community/disko/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, ... }: {
    apps.x86_64-linux.disko = {
      type = "app";
      program = "${disko.packages.x86_64-linux.disko}/bin/disko";
    };
    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/tailscale.nix
          ./modules/openssh.nix
          ./modules/qemu-guest-agent.nix
          ./modules/ffmpeg.nix
          ./modules/syncthing.nix
          ./modules/samba.nix
          ./modules/surrealdb.nix
          ./modules/disko.nix
          disko.nixosModules.disko
        ];
      };
    };
  };
}
