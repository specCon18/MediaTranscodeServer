{ config, pkgs, lib, ... }:
{
  users.users.amethyst420 = {
    shell = pkgs.bash;
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$RdLBHOvUpb17egl0d16LT/$3Y2RD/tT1IZ0nkfAR13pp3IzBjvKLRgGpDPLobUeO23";
    description = "Brittney Stroud";
    extraGroups = [
      "mediashare"
    ];
  };
}