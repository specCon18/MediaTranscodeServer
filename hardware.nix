{lib, ...}:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];
  boot = {
    initrd = {
      availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sr_mod" "sd_mod" ]; 
      kernelModules = [ "amdgpu" "dm-snapshot" "dm-cache-default" ];
    };
    loader.grub.devices = [ "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi1" ];
    kernelModules = [ "kvm-amd" ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "23.11";
  time.timeZone = "America/Detroit";
  nix = {
    # nix flakes
    package = pkgs.nixUnstable; # or versioned attributes like nix_2_4
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    #auto maintainence
    settings.auto-optimise-store = lib.mkDefault true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    # prevent tampering
    readOnlyStore = true;
  };
  networking = {
    firewall.checkReversePath = "loose";
    hostName = "mediasync"; # Define your hostname.
    useDHCP = lib.mkDefault true;
  };
}