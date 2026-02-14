{pkgs, ...}: let
  firefoxVersion = pkgs.lib.concatStringsSep "." (pkgs.lib.take 2 (pkgs.lib.splitString "." pkgs.firefox.version));
in {
  programs.yt-dlp = {
    enable = true;
    settings = {
      downloader = "aria2c";
      remux-video = "mp4";
      downloader-args = "aria2c:'-c -x16 -s16 -k4M --file-allocation=falloc'";
      output = "~/YouTube/%(title)s.%(ext)s";
      user-agent = "Mozilla/5.0 (X11; Linux x86_64; rv:${firefoxVersion}) Gecko/20100101 Firefox/${firefoxVersion}";
      cookies-from-browser = "firefox";
    };
  };
  home.packages = with pkgs; [aria2];
}
