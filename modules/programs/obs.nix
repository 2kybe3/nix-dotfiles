{
  pkgs,
  config,
  ...
}: {
  programs = {
    firejail.wrappedBinaries = config.kybe.lib.firejail.make pkgs.obs-studio "obs" ["obs"];

    obs-studio = {
      enable = true;

      package = pkgs.obs-studio.override {
        cudaSupport = true;
      };

      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
      ];
    };
  };
}
