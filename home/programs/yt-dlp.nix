{
  pkgs,
  cpkgs,
  config,
  ...
}: let
  # Get the firefox version trimming so the only 2 first version blocks are used
  firefoxVersion = pkgs.lib.concatStringsSep "." (pkgs.lib.take 2 (pkgs.lib.splitString "." pkgs.firefox.version));
in {
  # Little alias usefull for downloading songs from yt-music for rmpc
  programs.zsh.shellAliases.yt-audio = ''yt-dlp -x --audio-format mp3 --audio-quality 0 -f bestaudio --embed-metadata --embed-thumbnail --output "%(title)s - %(artist)s.%(ext)s" -P ~/Music'';
  programs.yt-dlp = {
    enable = true;
    settings = {
      downloader = "aria2c";
      downloader-args = "aria2c:'-c -x32 -s32 -k4M --file-allocation=falloc'"; # requires patched aria2c (/patches/aria2-unlimited.patch)

      remux-video = "mp4";
      output = "${config.xdg.userDirs.videos}/youtube/%(title)s.%(ext)s";

      cookies-from-browser = "firefox";
    };

    # Manually construct the User-Agent from the firefox version so i do not have to change this in the future
    # Usefull for cookies-from-browser
    extraConfig = ''
      --user-agent "Mozilla/5.0 (X11; Linux x86_64; rv:${firefoxVersion}) Gecko/20100101 Firefox/${firefoxVersion}";
    '';
  };
  home.packages = [cpkgs.aria2-unlimited];
}
