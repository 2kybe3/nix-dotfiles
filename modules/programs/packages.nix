{
  pkgs,
  stable,
  ...
}: {
  environment.systemPackages =
    [stable.calibre]
    ++ (with pkgs; [
      ## Netowrking
      wget
      curl
      mtr

      cisco-packet-tracer_9
      jetbrains.datagrip
      element-desktop
      wireshark
      vesktop
      gimp

      gparted

      ## CLI
      speedtest-cli
      ripgrep-all
      neofetch
      pamixer # pulseaudio command line mixer
      ripgrep
      openssl
      ffmpeg
      psmisc # killall etc.
      ranger
      unzip
      socat
      p7zip
      delta
      jdk21
      glow
      file
      tldr
      fzf
      dig
      git
      bat
      fd
      gh

      ## TUI
      vim
      (btop.override {
        cudaSupport = true;
      })
      ncdu
      feh # Image Viewer

      ## Nix
      statix
      nixd

      ## Bash
      shellcheck

      ## Games
      (prismlauncher.override {
        jdks = [
          jdk21
        ];
      })

      jetbrains.idea
      recaf-launcher

      # Nixvim
      tree-sitter
      gcc

      home-manager
    ]);
}
