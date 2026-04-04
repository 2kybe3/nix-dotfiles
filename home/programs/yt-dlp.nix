{
  pkgs,
  config,
  ...
}:
let
  firefoxVersion = pkgs.lib.concatStringsSep "." (
    pkgs.lib.take 2 (pkgs.lib.splitString "." pkgs.firefox.version)
  );
in
{
  # Little alias useful for downloading songs from yt-music for rmpc
  programs.fish.shellAliases.yt-audio = ''yt-dlp -x --audio-format mp3 --audio-quality 0 -f bestaudio --embed-metadata --embed-thumbnail --output "%(title)s - %(artist)s.%(ext)s" -P ~/Music'';

  programs.yt-dlp = {
    enable = true;
    settings = {
      downloader = "aria2c";
      downloader-args = "aria2c:'-c -x16 -s16 -k4M --file-allocation=falloc'";

      output = "${config.xdg.userDirs.videos}/youtube/%(title)s.%(ext)s";

      cookies-from-browser = "firefox";
    };

    extraConfig = ''
      --user-agent "Mozilla/5.0 (X11; Linux x86_64; rv:${firefoxVersion}) Gecko/20100101 Firefox/${firefoxVersion}";
    '';
  };
  home.packages = [
    pkgs.aria2
    pkgs.python3Packages.bgutil-ytdlp-pot-provider
  ];
}
