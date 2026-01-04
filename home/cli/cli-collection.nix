{pkgs, ...}: {
  # collection of useful CLI apps
  home.packages = with pkgs; [
    tldr
    file
    killall
    libnotify
    htop
    btop
    unzip
    unrar # rar support in ark
    rsync
    trash-cli

    ripgrep
    fd
  ];

  imports = [
    ./fastfetch
  ];
}
