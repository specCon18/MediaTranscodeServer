{ config, pkgs, ... }:

{
  # make the tailscale command usable to users
  environment.systemPackages = with pkgs;[ 
    pkgs.tailscale
  ];

  # enable the tailscale service
  services.tailscale.enable = true;
}
