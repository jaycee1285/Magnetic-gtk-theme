{
  description = "GTK theme (Eliver) as a Nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.default = pkgs.stdenvNoCC.mkDerivation {
        pname = "magnetic-gtk-theme";
        version = "unstable";
        src = ./.;
        nativeBuildInputs = [ pkgs.gtk3 pkgs.sassc ];
        propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
        installPhase = ''
          bash ./install.sh -t grey,orange --tweaks Nord,Gruvbox,compact -d $out/share/themes
        '';
        meta = with pkgs.lib; {
          description = "Magnetic GTK theme (Eliver, flake)";
          homepage = "https://github.com/jaycee1285/magnetic-gtk-theme";
          license = licenses.gpl3Only;
          platforms = platforms.linux;
        };
      };
    };
}
