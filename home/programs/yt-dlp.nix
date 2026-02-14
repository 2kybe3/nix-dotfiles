{pkgs, ...}: {
  programs.yt-dlp = {
    enable = true;
    settings = {
      downloader = "aria2c";
      remux-video = "mp4";
      downloader-args = "aria2c:'-c -x16 -s16 -k4M --file-allocation=falloc'";
      output = "~/YouTube/%(title)s.%(ext)s";
    };
  };
  home.packages = with pkgs; [aria2];
}
