{ config, pkgs, lib, ... }:
{
    environment.systemPackages = with pkgs; [
        docker
    ];
    virtualisation.docker = {
        enable = true;
        liveRestore = false;
        autoPrune.enable = true;
    };
    
    # But allow docker containers to access the local machine
    networking.firewall.trustedInterfaces = [ "docker0" ];
}