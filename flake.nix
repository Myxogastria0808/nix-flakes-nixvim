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
      systems = "x86_64-linux";
    in
    {
    packages.x86_64-linux =
      let
        system = systems;
        # `makeNixvimWithModule` is used to create a standalone Neovim package that includes my custom configuration module.
        # Reference: https://nix-community.github.io/nixvim/user-guide/install.html#standalone-usage
        nvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
          # `makeNixvimWithModule` accept `pkgs`, `extraSpecialArgs`, `module`
          module = import ./config.nix;
        };
      in {
        default = nvim;
      };

    devShells.x86_64-linux =
      let
        system = systems;
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in {
        default =  pkgs.mkShell {
            packages = [
              inputs.self.packages.${system}.default
            ];
        };
      };
  };
}
