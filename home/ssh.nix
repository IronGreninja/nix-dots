{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      nephis = {
        hostname = "192.168.29.59";
      };
      nero = {
        hostname = "192.168.29.89";
      };
    };
  };
}
