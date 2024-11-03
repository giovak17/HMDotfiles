{ lib, config, pkgs, ...}: let 
username = "giovak";
dotfilesPath = "${config.home.homeDirectory}/HomeManager/dotfiles";

in {
  nixpkgs.config.allowUnfree = true;

  #For NON NIXOS
  #targets.genericLinux.enable = true;

  #NOTE: HOME OPTIONS
  home = {
    # that this is just "username = username;"
    inherit username;
    enableNixpkgsReleaseCheck = false;

    homeDirectory = "/home/${username}";

    stateVersion = "24.05";

    #This makes Mason in nvim work
    #https://www.reddit.com/r/NixOS/comments/1e29wld/using_mason_lazy_in_nixos/
    sessionPath = [
      "$HOME/.local/bin"
    ];

    packages = with pkgs; [
      # Screenshots
      hyprshot
      dunst
      starship
      brightnessctl
      # These are tools for go
      templ
      air
      go
      nodejs_22
      deno
      mycli
      pgcli
      python3
      python312Packages.pip
      tailwindcss
      fastfetch
      zellij
      gnumake
      jq
      ripgrep
      zip
      unzip
      unrar
      fd
      xclip
      wl-clipboard
      cargo
      typescript
      cinnamon.nemo
      pfetch
      gdb
      yazi
      wofi
      xdg-utils
      swww

      #GUI
      pavucontrol
      firefox
      waybar
      jetbrains.datagrip
      vscode
      discord
      anki
      onlyoffice-bin
      postman

    ];


    # Dotfiles
    file = {
      #".config/.zshrc".source = ./dotfiles/zshrc/.zshrc;
      ".config/nvim" = {
	      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/nvim";
	      #recursive = true;
      };

      ".config/kitty" = {
	      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/kitty";
      };

      ".config/dunst" = {
	      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/dunst";
      };

      ".config/fastfetch" = {
	      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/fastfetch";
      };

      ".config/starship.toml" = {
	      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/starship/starship.toml";
      };

      ".config/zellij" = {
	      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/zellij";
      };

      ".config/waybar" = {
	      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/waybar";
      };

      ".config/wofi" = {
	      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/wofi";
      };

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

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      defaultEditor = true;

      extraPackages = with pkgs; [
        # Language servers
        lua-language-server
        nil
        nixd
        clang

        # Linters
        ruff

        # Formatters
        nixpkgs-fmt
        stylua

        clang-tools
      ];
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
        z = "zellij -l default";
        winget = "winget.exe";
        y = "yazi";
      };

      initExtra = ''
        fastfetch --config examples/9.jsonc
      '';

      oh-my-zsh = {
        enable = true;
      };
    };

    starship = {
      enable = true;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };

}
