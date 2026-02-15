{
  pkgs,
  config,
  aria2-unlimited,
  ...
}: let
  firefoxVersion = pkgs.lib.concatStringsSep "." (pkgs.lib.take 2 (pkgs.lib.splitString "." pkgs.firefox.version));
in {
  programs.zsh.shellAliases.yt-audio = ''yt-dlp -x --audio-format mp3 --audio-quality 0 -f bestaudio --embed-metadata --embed-thumbnail --output "%(title)s - %(artist)s.%(ext)s" -P ~/Music'';
  programs.yt-dlp = {
    enable = true;
    settings = {
      downloader = "aria2c";
      remux-video = "mp4";
      downloader-args = "aria2c:'-c -x32 -s32 -k4M --file-allocation=falloc'";
      output = "${config.xdg.userDirs.videos}/youtube/%(title)s.%(ext)s";
      cookies-from-browser = "firefox";
    };
    extraConfig = ''
      --user-agent "Mozilla/5.0 (X11; Linux x86_64; rv:${firefoxVersion}) Gecko/20100101 Firefox/${firefoxVersion}";
    '';
  };
  home.packages = [aria2-unlimited];
}
