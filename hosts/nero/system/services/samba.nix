{username, ...}: {
  services.samba = {
    enable = true;
    settings = {
      global."allow insecure wide links" = "yes";

      Share = {
        "path" = "/home/${username}/SambaShareGuest_RO"; # just drop a symlink here to the file/dir to be shared
        "guest ok" = "yes";
        "force user" = "${username}";
        "read only" = "yes";
        "browseable" = "yes";
        "follow symlinks" = "yes";
        "wide links" = "yes"; # NOTE: explicitly set to no for writable shares
      };

      # Documents = {
      #   "path" = "/home/${username}/Documents";
      #   "guest ok" = "yes";
      #   "read only" = "no";
      #   "browseable" = "yes";
      #   "force user" = "${username}";
      #   "wide links" = "no";
      # };
    };
  };
}
