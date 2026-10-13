{
  description = "onion";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    thorium = {
      url = "github:Rishabh5321/thorium_flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    zen-browser,
    thorium,
    aagl,
    spicetify-nix,
    ...
  }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.onion = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
          ./hardware-configuration.nix

          home-manager.nixosModules.home-manager
          aagl.nixosModules.default
          spicetify-nix.nixosModules.default

          {
            programs.spicetify =
              let
                spicePkgs = spicetify-nix.legacyPackages.${system};
              in
              {
                enable = true;

                enabledCustomApps = with spicePkgs.apps; [
                  marketplace
                  lyricsPlus
                ];

                enabledExtensions = with spicePkgs.extensions; [
                  hidePodcasts
                  adblockify
                ];

                theme = spicePkgs.themes.catppuccin;
                colorScheme = "mocha";
              };

            nix.settings = aagl.nixConfig;

            programs.anime-game-launcher.enable = true;

            environment.systemPackages = [
              zen-browser.packages.${system}.default
              thorium.packages.${system}."thorium-sse4"
            ];

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              users.onion = import ./home/default.nix;
            };
          }
        ];
      };
    };
}
