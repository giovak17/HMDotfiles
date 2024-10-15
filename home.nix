{ lib, pkgs, ...}: let 
username = "giovak";

in {
  nixpkgs.config.allowUnfree = true;

  #For NON NIXOS
  targets.genericLinux.enable = true;

  #NOTE: HOME OPTIONS
  home = {
    # that this is just "username = username;"
    inherit username;

    homeDirectory = "/home/${username}";

    stateVersion = "24.05";

    packages = with pkgs; [
      neovim
      # Thes are tools for go
      templ
      air
      go
      gopls
      #
      nodejs_22
      mycli
      pgcli
      python3
      python312Packages.pip
      tailwindcss
      fastfetch
      zellij
      jq
      ripgrep
      zip
      unzip
      unrar
      fd
      xclip
      cargo
      typescript
      cinnamon.nemo
      pfetch
      gdb
      gcc
      yazi
      xdg-utils
      mysql84
    ];

    file = {
      #".config/.zshrc".source = ./dotfiles/zshrc/.zshrc;
      ".config/nvim".source = ./dotfiles/nvim;
      ".config/starship.toml".source = ./dotfiles/starship/starship.toml;
      ".config/zellij".source = ./dotfiles/zellij;
    };

  };

  #NOTE: PROGRAMS OPTIONS
  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "giovak";
      userEmail = "kevin.giovanni1703@gmail.com";
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        v = "nvim";
        py = "python";
        shn = "shutdown now";
        cl = "clear";
        z = "zellij";
        winget = "winget.exe";
      };

      oh-my-zsh = {
        enable = true;
      };
    };

    starship = {
      enable = true;
    };

  };


}
