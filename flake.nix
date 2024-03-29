{
  description = "Simple Flake Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
      "x86_64-linux"
    ];
    mkPkgs = system: import nixpkgs {inherit system;};
  in {
    templates.default = {
      path = ./template;
      description = "Default simple nix flake project template.";
    };

    # Nix files formatter (alejandra, nixfmt or nixpkgs-fmt)
    # Run with `nix fmt`
    formatter = forAllSystems (
      system: let
        pkgs = mkPkgs system;
      in
        pkgs.alejandra
    );
  };
}
