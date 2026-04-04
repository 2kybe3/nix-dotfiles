{
  self,
  pkgs,
  config,
  mpdscribble,
  ...
}:
{
  sops.secrets."last.fm" = {
    sopsFile = "${self}/secrets/last.fm.yaml";
    mode = "0400";
  };
  services = {
    mpd = {
      enable = true;
      extraArgs = [ "--verbose" ];
      network.startWhenNeeded = true;
      # fifo is for rmpc cava
      extraConfig = ''
        audio_output {
          type "pulse"
          name "PulseAudio"
        }

        audio_output {
          type "fifo"
          name "rmpc_fifo"
          path "/tmp/rmpc.fifo"
          format "44100:16:2"
        }
      '';
    };
    mpd-mpris.enable = true;
    mpdscribble = {
      enable = true;
      package = pkgs.mpdscribble;
      endpoints = {
        "last.fm" = {
          passwordFile = config.sops.secrets."last.fm".path;
          username = "kybe236";
        };
      };
    };
  };
  home.packages = [ pkgs.playerctl ];
}
