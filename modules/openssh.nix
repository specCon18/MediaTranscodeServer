{ config, pkgs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        openssh
    ];
    services.openssh = lib.mkDefault {
        enable = true;
        openFirewall = true;
        startWhenNeeded = true;
        settings = {
            KexAlgorithms = [ "curve25519-sha256@libssh.org" ];
            PermitRootLogin = "no";
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
        };
    };
    security.pam = lib.mkDefault {
        enableSSHAgentAuth = true;
        services.sudo.sshAgentAuth = true;
    };
    networking.firewall.allowedTCPPorts = [ 22 ];
}