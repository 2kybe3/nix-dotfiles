{
  pkgs,
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
  environment.systemPackages = with pkgs; [
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
