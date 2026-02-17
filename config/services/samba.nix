{
  ig.samba = {user, ...}: {
    nixos.services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "smbnix";
          "netbios name" = "smbnix";
          "security" = "user";
          "hosts allow" = "192.168.29. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";

          "allow insecure wide links" = "yes";
        };
        Share = {
          "path" = "/home/${user.userName}/SambaShareGuest_RO"; # just drop a symlink here to the file/dir to be shared
          "guest ok" = "yes";
          "force user" = "${user.userName}";
          "read only" = "yes";
          "browseable" = "yes";
          "follow symlinks" = "yes";
          "wide links" = "yes"; # NOTE: explicitly set to no for writable shares
        };

        # Documents = {
        #   "path" = "/home/${user.userName}/Documents";
        #   "guest ok" = "yes";
        #   "read only" = "no";
        #   "browseable" = "yes";
        #   "force user" = "${username}";
        #   "wide links" = "no";
        # };
      };
    };
  };
}
