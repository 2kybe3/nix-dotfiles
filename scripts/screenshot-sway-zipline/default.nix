{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "screenshot-sway-zipline";
  src = ./.;

  buildInputs = [
    pkgs.grim
      pkgs.slurp
      pkgs.jq
      pkgs.curl
      pkgs.wl-clipboard-rs
  ];
  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin

    cp ${./screenshot-sway-zipline.bash} $out/bin/screenshot-sway-zipline

    wrapProgram $out/bin/screenshot-sway-zipline --prefix PATH : "${pkgs.grim}/bin:${pkgs.slurp}/bin:${pkgs.jq}/bin:${pkgs.curl}/bin:${pkgs.wl-clipboard}/bin"
    '';
}
