{
  boot.kernel.sysctl = {
    # The Magic SysRq key is a key combo that allows users connected to the
    # system console of a Linux kernel to perform some low-level commands.
    # Disable it, since we don't need it, and is a potential security concern.
    "kernel.sysrq" = 0;
  };

  security = {
    # allow wayland lockers to unlock the screen
    # TODO: these don't need to be set as default for all hosts.
    # Move them to the host using them, or couple them with e.g. hyprland
    pam.services.swaylock.text = "auth include login";
    pam.services.hyprlock.text = "auth include login";
  };
}
