{
  ig.virt.provides = {
    qemu = {user, ...}: {
      # https://discourse.nixos.org/t/virt-manager-cannot-find-virtiofsd/26752/2
      description = ''
        Requires-Groups: libvirtd, kvm
      '';
      nixos = {pkgs, ...}: {
        virtualisation.libvirtd = {
          enable = true;
          qemu.vhostUserPackages = [pkgs.virtiofsd];
        };
        programs.virt-manager.enable = true;
        users.users.${user.userName}.extraGroups = ["libvirtd" "kvm"];
      };
      homeManager = {
        # remove warning when starting virt-manager for the first time
        dconf.settings = {
          "org/virt-manager/virt-manager/connections" = {
            autoconnect = ["qemu:///system"];
            uris = ["qemu:///system"];
          };
        };
      };
    };

    podman = {user, ...}: {
      description = ''
        Requires-Groups: podman
        Optional: users.users.<name>.linger
      '';
      nixos = {
        virtualisation.containers.enable = true;
        virtualisation.podman = {
          enable = true;
          defaultNetwork.settings = {dns_enabled = true;};
        };
        users.users.${user.userName} = {
          extraGroups = ["podman"];
          linger = true;
        };
      };
    };
  };
}
