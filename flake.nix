{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { nixpkgs, nixvim, ... }:
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

    withOptions = forAllSystems ({ pkgs, system }:
      (args:
        let
          nixvimSource = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./default.nix {
              lib = pkgs.lib;
              mixvim = args;
              inherit system;
            };
          };
          nixvimPackage = nixvimSource.makeNixvimWithModule nixvimModule;
        in
        nixvimPackage
      )
    );
  in {
    inherit withOptions;
    packages = forAllSystems ({ system, ... }: { default = withOptions.${system} { xcode.enable = false; rpc.enable = false; }; });
  };
}
