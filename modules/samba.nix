{config, lib, pkgs, modulesPath, ... }:
{
  environment.systemPackages = with pkgs; [
    samba4Full
  ];
  services.samba = {
    package = pkgs.samba4Full;
    enable = true;
    shares = { 
      media = { 
        path = "/mnt/shares/media";
        "read only" = true;
        browseable = "yes";
        "guest ok" = "yes";
        comment = "Media Share";
      };
    };
    invalidUsers = [ "root" ];
    openFirewall = true;
  };
  networking.firewall = {
    allowedTCPPorts = [ 5357 ];
    allowedUDPPorts = [ 3702 ];
  };
}