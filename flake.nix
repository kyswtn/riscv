{
  description = "Nix flake for all things RISC-V";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      mkInputs = system: {
        pkgs = nixpkgs.legacyPackages.${system};
      };
      forAllSupportedSystems = fn:
        with nixpkgs.lib; attrsets.genAttrs systems.flakeExposed
          (system: fn (mkInputs system));
    in
    {
      packages = forAllSupportedSystems (inputs: with inputs; {
        sail-riscv = pkgs.callPackage ./packages/sail-riscv.nix { };
      });

      devShells = forAllSupportedSystems (inputs: with inputs; {
        default = pkgs.mkShellNoCC {
          packages = [ ];
        };
      });
    };
}
