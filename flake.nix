{
  description = "NixOS configuration for Proxmox";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    nixos-generators = {
      url = github:nix-community/nixos-generators
      inputs.nixpkgs.follows = "nixpkgs";
    }
  };

  outputs = { self, nixpkgs, nixos-generators ... }: {
    nixosConfigurations = {
      vm = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "proxmox";
        modules = [
          ./modules/docker.nix
          ./modules/tailscale.nix
          ./modules/openssh.nix
          ./modules/disko.nix
        ];
      };
      syncthing = nixos-generators.nixosGenerate {
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
    };
  };
}
