{pkgs, ...}: let
  shellAliases = {
    hm = "home-manager";
    v = "nvim";
    cat = "bat";
    man = "batman";
  };
in {
  imports = [
    ./cli-collection.nix
  ];

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autocd = true;
    defaultKeymap = "viins";
    history = {
      size = 5000;
      save = 5000;
      share = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };
    enableCompletion = true;
    completionInit = "autoload -Uz compinit && compinit";
    syntaxHighlighting.enable = true; # zsh-syntax-highlighting, to be sourced at the end
    # historySubstringSearch = {
    #   enable = true;
    #   searchUpKey = "$terminfo[kcuu1]";
    #   searchDownKey = "$terminfo[kcud1]";
    # };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "fzf-tab"; # needs to be loaded after compinit and before zsh-autosuggestions
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
    ];

    initExtraFirst =
      /*
      bash
      */
      ''
        # Enable Powerlevel10k instant prompt
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';

    initExtra =
      /*
      bash
      */
      ''

        # Completion styling
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # ignore case autocompletion
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}" # show colors in tab completion
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' # disable default zsh completion menu for zsh-tab
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath' # fzf with zoxide

        # Load personal p10k prompt config
        [[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh

        bindkey "$terminfo[kcuu1]" history-search-backward
        bindkey "$terminfo[kcud1]" history-search-forward
      '';
    inherit shellAliases;
  };
  xdg.configFile."zsh/p10k.zsh".source = ./p10k.zsh;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [batman];
    config = {
      theme = "TwoDark";
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
    extraOptions = ["--octal-permissions"];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
