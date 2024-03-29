{ config, pkgs, ... }:
{

  # (naming is legacy)
  services.xserver = {
    # Enable the GNOME Desktop Environment.
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Configure keymap in X11
    layout = "gb";
    xkbVariant = "";
  };

  #   programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  #   xwayland.enable = true;
  # };

  # pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    # gnome-terminal
    # gedit # text editor
    epiphany # web browser
    geary # email reader
    # evince # document viewer
    gnome-characters
    # totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';
  hardware.i2c.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];


  # missing extensions not installed from NixOS https://extensions.gnome.org/extension/4652/adjust-display-brightness/
  environment.systemPackages = with pkgs; [
    # monitor control
    ddcutil

    gnome.dconf-editor

    (makeAutostartItem { name = "guake"; package = guake; })

    gnomeExtensions.vitals
    # gnomeExtensions.useless-gaps
    gnomeExtensions.wireless-hid
    gnomeExtensions.unite

    # sound
    pavucontrol
  ];
  environment.sessionVariables."GUAKE_ENABLE_WAYLAND" = "true";
}
