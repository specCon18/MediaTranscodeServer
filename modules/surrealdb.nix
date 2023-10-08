{config, lib, pkgs, modulesPath, ... }:
{
  environment.systemPackages = with pkgs; [
    surrealdb
  ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "surrealdb" ];
}