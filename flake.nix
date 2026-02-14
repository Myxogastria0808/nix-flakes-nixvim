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
      system = "x86_64-linux";
    in
    {
    packages.x86_64-linux.default =
      let
        system = system;
        nvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
          module = import ./config.nix;
        };
      in nvim;

    devShells.x86_64-linux.default =
      let
        system = system;
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in pkgs.mkShell {
          packages = [
            inputs.self.packages.${system}.default
          ];
      };
  };
}
