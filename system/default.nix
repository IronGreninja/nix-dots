{
  username,
  host,
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  ...
}: let
in {
  networking.hostName = host;

  imports = [
    ./core
    ./extra
    ./nix
    ./programs

    # Load host specific config
    ../hosts/${host}/hardware-configuration.nix
    ../hosts/${host}/configuration.nix
  ];

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Virtual console(tty) font settings
  console = {
    # earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v28n.psf.gz";
    packages = with pkgs; [terminus_font];
    keyMap = "us";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true; # required for setting shell above

  # enable zsh autocompletion for system packages (systemd, etc)
  environment.pathsToLink = ["/share/zsh"];

  time.timeZone = lib.mkDefault "Asia/Kolkata";

  environment.systemPackages = with pkgs; [man-pages man-pages-posix];
  documentation.dev.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
