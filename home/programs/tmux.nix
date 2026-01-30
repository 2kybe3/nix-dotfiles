{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # remap prefix from 'C-b' to 'C-a'
      unbind C-b
      set-option -g prefix C-a
      bind-key C-a send-prefix

      # remap split command
      bind b split-window -h
      bind v split-window -v
      unbind '"'
      unbind %

      bind r source-file ~/.tmux.conf

      # fast pane switching (Meta + vim)
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      # Allow mouse support
      set -g mouse on

      # Neovim stuff
      set -g status-style bg=default
      set -g status-left-length 99
      set -g status-right-length 99
      set -g status-justify centre
    '';
  };
}
