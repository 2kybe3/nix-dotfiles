{pkgs, ...}: {
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
    mpd-mpris.enable = true;
  };
  home.packages = [pkgs.playerctl];
}
