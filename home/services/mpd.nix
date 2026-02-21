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
  };
  home.packages = [pkgs.playerctl];
}
