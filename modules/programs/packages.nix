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
    glow
    file
    fzf
    dig
    bat
    git
    fd
    gh

    ## TUI
    (btop.override {
      cudaSupport = true;
    })
    ncdu
    feh # Image Viewer

  ]);
}
