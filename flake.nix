{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";

    # flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { nixpkgs, nixvim, flake-parts, ... }@inputs:
  let
    forAllSystems = function: nixpkgs.lib.genAttrs [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ] (system:
      function (
        {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          inherit system;
        }
      )
    );
  in {
    withOptions = forAllSystems ({ pkgs, system }: (args:
    let
      nixvimSource = nixvim.legacyPackages.${system};
      nixvimModule = {
        inherit pkgs;
        module = import ./default.nix {
          lib = pkgs.lib;
          mixvim = args;
        };
      };
      nixvimPackage = nixvimSource.makeNixvimWithModule nixvimModule;
    in
    {
      default = nixvimPackage;
    }
    ));

    packages = forAllSystems ({ pkgs, system }:
    let
      nixvimSource = nixvim.legacyPackages.${system};
      nixvimModule = {
        inherit pkgs;
        module = import ./default.nix {
          lib = pkgs.lib;
          mixvim = {
            xcode.enable = false;
            rpc.enable = false;
          };
        };
      };
      nixvimPackage = nixvimSource.makeNixvimWithModule nixvimModule;
    in
    {
      default = nixvimPackage;
    });
  };
}
#   flake-parts.lib.mkFlake { inherit inputs; } {
#     systems = [
#       "aarch64-darwin"
#       "aarch64-linux"
#       "x86_64-darwin"
#       "x86_64-linux"
#     ];
#     perSystem = { pkgs, system, ... }:
#     let
#       nixvimSource = nixvim.legacyPackages.${system};
#       nixvimModule = {
#         inherit pkgs;
#         module = import ./default.nix;
#       };
#       nixvimPackage = nixvimSource.makeNixvimWithModule nixvimModule;
#     in
#     {
#       flake.withOptions = args@{ ... }: (nixvimSource.makeNixvimWithModule ({
#         inherit pkgs;
#         module = import ./default.nix;
#         nvim.genericModes = ["n"];
#       }));
#       packages.default = nixvimPackage;
#     };
#   };
# }
