# Structure

| Path | Purpose |
| --- | --- |
| `flake.nix` | Entry point for everything. |
| `home/` | Home-manager modules. |
| `system/` | Same as above but for NixOS. |
| `modules/` | Standalone NixOS & home-manager modules. Intended to be more generic as compared to modules in `home/` or `system/`, so they can be distributed. |
| `pkgs/` | Custom packages. |
| `hosts/` | Host specific configuration. |

All modules in `home/` and `system/` are imported in every host by default. And any module in it does one of the following to any configured component / service / program:

- Enable them (for shared config).
- Expose custom option (for enabling them per host).
- Configure but do not enable (So they can be enabled per host by their usual `config.**.enable`).

### Credits / Inspiration

[Misterio77 starter configs](https://github.com/Misterio77/nix-starter-configs), [ZaneyOS's dots](https://gitlab.com/Zaney/zaneyos), [VimJoyer](https://www.youtube.com/@vimjoyer), [LibrePhoenix](https://www.youtube.com/@librephoenix), [Fufexan's dots](https://github.com/fufexan/dotfiles)

