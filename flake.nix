# flake.nix — Nix flake definition for nix-flakes-nixvim.
# Produces four outputs for x86_64-linux (manually verified), aarch64-darwin, and x86_64-darwin (unverified — no macOS machine):
#   packages.<system>.default  : standalone Neovim package (config/default.nix) — works in any terminal; image previews render as chafa character art
#   packages.<system>.kitty    : standalone Neovim package (config/kitty.nix) — for terminals that speak the Kitty Graphics Protocol (kitty, WezTerm, ghostty); image previews render as real per-pixel images via image.nvim
#   devShells.<system>.default : development shell that includes packages.<system>.default
#   devShells.<system>.kitty   : development shell that includes packages.<system>.kitty
# Inputs: nixpkgs (nixos-unstable) + nixvim (follows nixpkgs).
{
  description = "nix-flakes-nixvim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems =
        f:
        builtins.listToAttrs (
          map (system: {
            name = system;
            value = f system;
          }) systems
        );
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          # `makeNixvimWithModule` is used to create a standalone Neovim package that includes my custom configuration module.
          # Reference: https://nix-community.github.io/nixvim/user-guide/install.html#standalone-usage
          makeConfig =
            module:
            inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
              # `makeNixvimWithModule` accepts `pkgs`, `extraSpecialArgs`, `module`
              inherit pkgs;
              inherit module;
            };
        in
        {
          default = makeConfig (import ./config);
          kitty = makeConfig (import ./config/kitty.nix);
        }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = [
              inputs.self.packages.${system}.default
            ];
          };
          kitty = pkgs.mkShell {
            packages = [
              inputs.self.packages.${system}.kitty
            ];
          };
        }
      );
    };
}

