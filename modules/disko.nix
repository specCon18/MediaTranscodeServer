{
  disko.devices = {
    disk = {
      sda = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ "--allow-discards" ];
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "5G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
          var = {
            size = "5G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/var";
              mountOptions = [
                "defaults"
              ];
            };
          };
          tmp = {
            size = "20G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/tmp";
              mountOptions = [
                "defaults"
              ];
            };
          };
          var-lib = {
            size = "10G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/var/lib";
              mountOptions = [
                "defaults"
              ];
            };
          };
          nix = {
            size = "30G";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
              };
            };
          };
          home = {
            size = "5G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
            };
          };
          media = {
            size = "200G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/srv/shares/media";
              mountOptions = [
                "defaults"
              ];
            };
          };
          raw = {
            size = "1G";
          };
        };
      };
    };
  };
}