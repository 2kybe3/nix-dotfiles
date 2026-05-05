{
  pkgs,
  cpkgs,
  ...
}:
{
  environment.systemPackages = [
    cpkgs.home-manager
  ]
  ++ (with pkgs; [
    ## Networking
    traceroute
    tcpdump
    curl
    wget
    dig
    mtr

    ## CLI
    shellcheck
    fastfetch
    ripgrep
    openssl
    unzip
    jdk21
    fwupd
    glow # Markdown viewer
    lsof # allows seeing who has a file open
    file
    fzf # Fuzzy finder
    dig
    bat
    git
    fd # FIle Finder
    gh # Github

    ## TUI
    btop-cuda
    ncdu
    imv # Image Viewer
  ]);
}
