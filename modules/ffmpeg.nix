{config, lib, pkgs, modulesPath, ... }:
{
  environment.systemPackages = with pkgs; [
    ffmpeg_6-full
  ];
}