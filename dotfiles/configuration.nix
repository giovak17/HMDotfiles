# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Tijuana";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

   i18n.inputMethod = {
     type = "fcitx5";
     enable = true;
     fcitx5.addons = with pkgs; [
       fcitx5-mozc
       fcitx5-gtk
       fcitx5-anthy
     ];
   };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.giovak = {
    isNormalUser = true;
    description = "giovak";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.direnv.enable = true;

  programs.nix-ld.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
	xorg.setxkbmap
	niri
	xwayland-satellite
	# Windows fonts
	corefonts
	vistafonts
	kitty
	clang
	gcc
  	home-manager
	git
	libstdcxx5
	libcxx
	llvm_18
	llvmPackages_12.stdenv
	libcxxStdenv

	appimage-run
  ];

  fonts.packages = with pkgs; [
  fira-code
  fira-code-symbols
  udev-gothic-nf
  ];

# Run unpatched dynamic binaries on NixOS.
#programs.nix-ld = {
#	enable = true;
#	libraries = with pkgs; [
#	    stdenv.cc.cc
#	    libcxx
#	];
#};

# Window manager
programs.hyprland.enable = true;
xdg.portal.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

#programs.neovim.defaultEditor=true;

  # Changing shell to ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

   # Greeter greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --cmd niri-session";
        user = "giovak";
      };
    };
  };

    # this is a life saver.
  # literally no documentation about this anywhere.
  # might be good to write about this...
  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };


  #Sound configuration
  #sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  #Make sound work again
  boot.kernelParams = [ "snd-intel-dspcfg.dsp_driver=1" ];

    #BT stuff

  hardware.bluetooth = {
	enable = true;
	powerOnBoot = true;
	settings = {
		General = {
			Experimental = true;
			Enable = "Source,Sink,Media,Socket";
		};
	};
};
  services.blueman.enable = true;

  # Using bluetooth headset button to control media player
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
};

  # Virtual box
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "giovak" ];
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;

# Supposed to enable VULKAN
  #hardware.opengl.enable = true;
  #hardware.opengl.driSupport = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # LEMP, XAMPP equivalent
  #services.httpd.adminAddr = "localhost";
#
#  services.httpd.virtualHosts."localhost" = {
#   documentRoot = "/var/www/html";
#   # want ssl + a let's encrypt certificate? add forceSSL = true; right here
#  };
#
#    # apache
#   services.httpd.enable = true;
#   services.httpd.package = pkgs.apacheHttpd;
#
#  #php
#  services.httpd.enablePHP = true;
#  services.httpd.phpPackage = pkgs.php;

  #mysql
  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;

  # end LEMP

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Flatpak
  services.flatpak.enable = true;

# Improve battery life
  # Better scheduling for CPU cycles - thanks System76!!!
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  # Enable TLP (better than gnomes internal power manager)
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  # Disable GNOMEs power management
  services.power-profiles-daemon.enable = false;

  # Enable powertop
  powerManagement.powertop.enable = true;

  # Enable thermald (only necessary if on Intel CPUs)
  services.thermald.enable = true;

  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 80 443 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = false;
  #networking.firewall.allowPing = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
