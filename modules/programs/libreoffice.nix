{
  pkgs,
  stable,
  config,
  ...
}: {
  programs.firejail.wrappedBinaries = config.kybe.lib.firejail.make pkgs.firejail "libreoffice" [
    "libreoffice"
    "sbase"
    "scalc"
    "sdraw"
    "simpress"
    "smath"
    "soffice"
    "swriter"
    "unopkg"
  ];
  # TODO: https://nixpk.gs/pr-tracker.html?pr=494721
  environment.systemPackages = with stable; [
    libreoffice-qt

    # Spellcheck
    hunspell
    hunspellDicts.de-de
    hunspellDicts.en-us

    # hyphenation
    hyphenDicts.de-de
    hyphenDicts.en-us
  ];
}
