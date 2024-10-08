{ inputs, modules, ... }: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ./brew.nix
    ./builders.nix
    ./nixbuildnet.nix
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nico = {
      imports = with inputs.self.homeManagerModules; [ cli gui ./home (modules + /darwinAppSymlink.nix) ];
      home.stateVersion = "23.11";
      home.username = "nico";
      home.homeDirectory = "/Users/nico";
    };
  };

  # assumes rosetta
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
  # starts a VM!
  nix.linux-builder.enable = true;
  nix.linux-builder.ephemeral = true;
  nix.settings.trusted-users = [ "root" "nico" "@admin" ];


  nixpkgs.hostPlatform = "aarch64-darwin";
  users.users."nico".home = "/Users/nico";

  # we use the app instead
  # services.tailscale.enable = false;
}
