{config, lib, pkgs, modulesPath, ... }:
{
  environment.systemPackages = with pkgs; [
    samba4Full
  ];
  services.samba = {
    enable = true;
    package = pkgs.samba4Full;
    securityType = "user";
    extraConfig = ''
      server string = mediasync
      security = user 
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 10.18.1. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = { 
      media = { 
        path = "/mnt/shares/media";
        browseable = "yes";
        comment = "Media Share";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "amethyst420";
        "force group" = "mediashare";
      };
    };
    invalidUsers = [ "root" ];
    openFirewall = true;
  };
}