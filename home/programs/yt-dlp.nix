{pkgs, ...}: {
  programs.yt-dlp = {
    enable = true;
    settings = {
      downloader = "aria2c";
      downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
      output = "~/YouTube/%(title)s.%(ext)s";
    };
  };
  home.packages = with pkgs; [aria2];
}
