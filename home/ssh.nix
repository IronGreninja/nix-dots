{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      nephis = {
        hostname = "192.168.29.59";
      };
      nero = {
        hostname = "192.168.29.89";
      };
      asterion = {
        hostname = "192.168.29.69";
        port = 4004;
      };
    };
  };
}
