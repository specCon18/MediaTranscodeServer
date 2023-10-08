{
  description = "NixOS configuration for Proxmox";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    disko = {
      url = "github:nix-community/disko/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = github:nix-community/nixos-generators;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-generators, disko, ... }: {
    apps.x86_64-linux.disko = {
      type = "app";
      program = disko.packages.x86_64-linux.disko;
    };
    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/docker.nix
          ./modules/tailscale.nix
          ./modules/openssh.nix
          ./modules/qemu-guest-agent.nix
          ./modules/ffmpeg.nix
          ./modules/disko.nix
          {
            _module.args.disks = [ "/dev/sda" ];
          }
          disko.nixosModules.disko
        ];
      };
      sync = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "docker";
        modules = [
          ./modules/syncthing.nix
        ];
      };
      samba = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "docker";
        modules = [
          ./modules/samba.nix  
        ];
      };
      db = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "docker";
        modules = [
          ./modules/surrealdb.nix  
        ];
      };
    };
  };
}
