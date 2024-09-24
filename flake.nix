{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { nixpkgs, nixvim, flake-parts, ... }@inputs: 
  flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
    perSystem = { pkgs, system, ... }:
    let
      nixvimSource = nixvim.legacyPackages.${system};
      nixvimModule = {
        inherit pkgs;
        module = import ./default.nix;
      };
      nixvimPackage = nixvimSource.makeNixvimWithModule nixvimModule;
    in
    {
      packages.default = nixvimPackage;
    };
  };
}
