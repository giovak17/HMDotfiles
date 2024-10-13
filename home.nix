{ lib, pkgs, ...}: let 
username = "giovak";

in {
  nixpkgs.config.allowUnfree = true;

  #For NON NIXOS
  targets.genericLinux.enable = true;

  #NOTE: HOME OPTIONS
  home = {
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

    # that this is just "username = username;"
    inherit username;

    homeDirectory = "/home/${username}";

    stateVersion = "24.05";

    file = {
      "hello.txt" = {
        text = "echo 'Hello world'";
        executable = true;
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


  };


}
