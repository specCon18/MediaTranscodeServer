{config, lib, pkgs, nixpkgs-unfree, ... }:
{
  environment.systemPackages = [
    nixpkgs-unfree.legacyPackages.x86_64-linux.surrealdb
  ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "surrealdb" ];
}