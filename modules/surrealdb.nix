{config, lib, pkgs, modulesPath, ... }:
{
  environment.systemPackages = with pkgs; [
    surrealdb
  ];
}