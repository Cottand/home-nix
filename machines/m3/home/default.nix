{ pkgs, ... }: {
  home.packages = with pkgs; with pkgs.jetbrains; [
    idea
    goland
    webstorm

    spotify

    monitorcontrol

    utm
    nicotine-plus
    vlc-bin

    prismlauncher

    nixd
    go
    ollama

  ];

  home.shellAliases."tailscale" = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
}
