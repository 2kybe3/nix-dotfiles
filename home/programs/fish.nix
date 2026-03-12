let
  nixosConfigPath = "~/.dotfiles";
in {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if ! pgrep -u "$USER" ssh-agent > /dev/null; then
          eval "$(ssh-agent -s)"
      end

      if ! ssh-add -l | grep -q "SHA256:bc7E9tLPDWpad1A9/XBswtUUskgN7m5xdbWH1omZ71I"; then
          ssh-add ~/.ssh/kybe
      end
    '';
    shellAliases = {
      tm = "tmux attach || tmux new";
      os-update = "nix flake update --flake ${nixosConfigPath}; sudo nixos-rebuild switch --flake ${nixosConfigPath}#knx --upgrade; home-manager switch --flake ${nixosConfigPath} --show-trace";
    };
  };
}
