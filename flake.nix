# flake.nix — Nix flake definition for nix-flakes-nixvim.
# Produces two outputs targeting multiple systems:
#   packages.<system>.default  : standalone Neovim package built with NixVim (makeNixvimWithModule)
#   devShells.<system>.default : development shell that includes the Neovim package
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
      forAllSystems = f:
        builtins.listToAttrs (
          map (system: { name = system; value = f system; }) systems
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
          nixvimConfig = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
            # `makeNixvimWithModule` accepts `pkgs`, `extraSpecialArgs`, `module`
            inherit pkgs;
            module = import ./config;
          };
        in
        { default = nixvimConfig; }
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
        }
      );
    };
}

