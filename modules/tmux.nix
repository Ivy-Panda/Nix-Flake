{ config, pkgs, ... }: {

   programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g status-right '#{?client_prefix,#[reverse]<CMD>#[noreverse] ,}"#{=21:pane_title}" %H:%M %d-%b-%y'

      setw -g mode-keys vi
      
      unbind l
      bind C-l last-window

      unbind C-b
      set -g prefix C-f
      bind C-f send-prefix

      bind g split-window
      bind v split-window -h

      bind -r Space next-layout
      bind -r C-o rotate-window 
      bind -r \{ swap-pane -U
      bind -r \} swap-pane -D

      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

      bind -r C-h resize-pane -L
      bind -r C-j resize-pane -D
      bind -r C-k resize-pane -U
      bind -r C-l resize-pane -R

      bind -r M-h resize-pane -L 5
      bind -r M-j resize-pane -D 5
      bind -r M-k resize-pane -U 5
      bind -r M-l resize-pane -R 5

      bind -r S-h refresh-client -L 10
      bind -r S-j refresh-client -D 10
      bind -r S-k refresh-client -U 10
      bind -r S-l refresh-client -R 10

      '';
    };
  }
  
