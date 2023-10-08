{ disks ? [ "/dev/sda" ], ... }: {
  disko.devices = {
    disk = {
      disk-0 = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              type = "filesystem";
              name = "ESP";
              start = "1MiB";
              end = "2g";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            }
            {
              name = "swap";
              type = "partition";
              start = "2G";
              end = "26G";
              part-type = "primary";
              content = {
                type = "swap";
                randomEncryption = true;
              };
            }
            {
              type = "partition";
              name = "luks";
              start = "40G";
              end = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ "--allow-discards" ];
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            }
          ];
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            type = "lvm_lv";
            size = "256G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
          home = {
            type = "lvm_lv";
            size = "40G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
            };
          };
          media = {
            type = "lvm_lv";
            size = "200G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/mnt/shares/media";
            };
          };
        };
      };
    };
  };
}
