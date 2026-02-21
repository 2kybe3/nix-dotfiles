{
  self,
  pkgs,
  config,
  ...
}: {
  sops.secrets."last.fm" = {
    sopsFile = "${self}/secrets/last.fm.yaml";
    mode = "0400";
  };
  services = {
    mpd = {
      enable = true;
      extraArgs = ["--verbose"];
      network.startWhenNeeded = true;
      extraConfig = ''
        audio_output {
          type "pulse"
          name "PulseAudio"
        }
      '';
    };
    mpdscribble = {
      enable = true;
      endpoints = {
        "last.fm" = {
          passwordFile = config.sops.secrets."last.fm".path;
          username = "kybe236";
        };
      };
    };
  };
  home.packages = [pkgs.playerctl];
}
