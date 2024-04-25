{
  # Configure disks
  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["defaults" "umask=0077"];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  # Root
                  "/root" = {
                    mountpoint = "/";
                  };
                  # Home
                  "/home" = {
                    mountOptions = ["compress=zstd"];
                    mountpoint = "/home";
                  };
                  # Personal subvol
                  "/home/sonar" = {};
                  # Nix
                  "/nix" = {
                    mountOptions = ["compress=zstd" "noatime"];
                    mountpoint = "/nix";
                  };
                  # Subvolume for the swapfile
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap = {
                      swapfile.size = "32G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
