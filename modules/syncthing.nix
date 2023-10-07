{config, lib, pkgs, modulesPath, ... }:
{
  environment.systemPackages = with pkgs; [
    syncthing
  ];
  
  services.syncthing = {
    enable = true;
    dataDir = "/home/speccon18";
    openDefaultPorts = true;
    configDir = "/home/speccon18/.config/syncthing";
    user = "speccon18";
    group = "users";
    guiAddress = "0.0.0.0:8384";
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "syncthing_server" = { id = "N3UGNP6-ZU6JHBX-WNJDEUF-FV5DOWA-VAGFDYN-FIIMFRR-C3HGQHU-WOEIUQ6"; };
    };
    extraOptions.gui = {
      user = "admin";
      password = "Strife-Rerun-Lily-Pushover-Alongside-Raider0-Freebase";
    };
  };
  networking.firewall = {
    allowedUDPPorts = [ 8384 ];
  };
}