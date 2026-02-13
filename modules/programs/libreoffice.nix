{pkgs, ...}: {
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
