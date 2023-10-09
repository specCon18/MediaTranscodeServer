{config, lib, nixpkgs-unfree, modulesPath, ... }:
{
  environment.systemPackages = [
    nixpkgs-unfree.packages.x86_64-linux.surrealdb
  ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "surrealdb" ];
}