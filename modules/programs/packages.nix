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
    dig
    wget
    curl
    mtr

    ## CLI
    shellcheck
    fastfetch
    ripgrep
    openssl
    ffmpeg
    unzip
    jdk21
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
    (btop.override {
      cudaSupport = true;
    })
    ncdu
    feh # Image Viewer
  ]);
}
