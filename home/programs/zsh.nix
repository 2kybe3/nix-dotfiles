{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = "${config.xdg.configHome}/zsh";
    history = {
      append = true;
      extended = true;
      save = 12345;
      size = 12345;
    };
    initContent = ''
      if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        eval "$(ssh-agent -s)" >/dev/null
      fi

      ssh-add -l | grep -q ~/.ssh/kybe || ssh-add ~/.ssh/kybe >/dev/null 2>&1
    '';
    shellAliases = {
      _select_dir = "fd --hidden -t d . | fzf --preview 'ls -lah {}'";
      _select_file = "fd --hidden -t f . | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
      _fzf_compgen_path = "fd --hidden --follow --exclude '.git' . '$1'";

      fcd = "local dir; dir=$(_select_dir); [ -n '$dir' ] && cd '$dir'";
      fr = "local dir; dir=$(_select_dir); [ -n '$dir' ] && ranger '$dir'";
      fnv = "local file; file=$(_select_file); [ -n '$file' ] && nvim '$file'";

      gpgrh =
        # @goodnighttea
        # @koteyka32k
        # @2kybe3
        # @marni_
        # @tillay8
        # @lokfid
        ''
          gpg -e -a \
            -r 7292A69DAE47A4CBEF94F3F983592EB1EFCA1F70 \
            -r 91F1880E0A0171454DC3001571DB00F1652871F3 \
            -r 7FD88CB5B384C8525E4FFE2DD788AA964E27B3A4 \
            -r 4B2067C3BD6D410F13E536A343CE43938A3C7A8F \
            -r C68D18E129AA29F98A967A3A00588427560CD36F \
            -r 743BC859354C3E19BA44ED4720570E9CE5639D56 \
            -r 8ACF72AA6E17367D4EE49FAC94384F67FA501352
        '';

      tm = "tmux attach || tmux new";
      dev = "nix develop ~/.dotfiles#rust -c $SHELL";

      cd = "z";
    };
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
  };
}
