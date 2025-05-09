{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.nushell;
in {
  options.features.cli.nushell.enable = mkEnableOption "enable nushell";

  config = mkIf cfg.enable {
    programs.nushell = {
      enable = true;
      plugins = with pkgs.nushellPlugins; [
        skim
      ];
      envFile.text = ''
        $env.config.show_banner = false
        $env.NIX_PATH = "nixpkgs=channel:nixos-unstable"
        $env.NIX_LOG = "iunfo"
        $env.WEBKIT_DISABLE_COMPOSITING_MODE = "1"
        $env.TERMINAL = "kitty"
        $env.EDITOR = "nvim"
        $env.VISUAL = "zed"
        $env.XDG_DATA_HOME = $"($env.HOME)/.local/share"
        $env.FZF_DEFAULT_COMMAND = "fd --type f --exclude .git --follow --hidden"
        $env.FZF_DEFAULT_OPTS = "
          --preview='bat --color=always -n {}'
          --preview-window up:3:hidden:wrap
          --bind 'ctrl-/:toggle-preview'
          --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
          --color header:bold
          --header 'Press CTRL-Y to copy command into clipboard'"
        $env.FLAKE = $"($env.HOME)/p/nixos/nixos-config"
      '';
      configFile.text = ''
        if (tty) == "/dev/tty1" {
          exec uwsm start -S -F /run/current-system/sw/bin/Hyprland
        }
        if (tty) == "/dev/tty2" {
          exec gamescope -O HDMI-A-1 -W 1920 -H 1080 --adaptive-sync --hdr-enabled --rt --steam -- steam -pipewire-dmabuf -tenfoot
        }

        alias .. = cd ..
        alias ... = cd ...
        alias h = cd $env.HOME
        alias b = yazi
        alias lt = eza --tree --level=2 --long --icons --git
        alias grep = rg
        alias just = just --unstable

        alias n = nix
        alias nd = nix develop -c $nu.current-shell
        alias ns = nix shell
        alias nsn = nix shell nixpkgs#
        alias nb = nix build
        alias nbn = nix build nixpkgs#
        alias nf = nix flake

        alias nr = sudo nixos-rebuild --flake .
        alias nrs = sudo nixos-rebuild switch --flake .#(sys host | get hostname)
        alias snr = sudo nixos-rebuild --flake .
        alias snrs = sudo nixos-rebuild --flake . switch
        alias hm = home-manager --flake .
        alias hms = home-manager --flake . switch
        alias hmr = do { cd ~/projects/nix-configurations; nix flake lock --update-input dotfiles; home-manager --flake .#(whoami)@(hostname) switch }

        alias tsu = sudo tailscale up
        alias tsd = sudo tailscale down

        alias vi = nvim
        alias vim = nvim

        def history_fuzzy [] {
            let selected = (
                history
                | uniq
                | get command
                | sk --height 40% --layout=reverse --color=fg:#f8f8f2,bg:#282a36,current_bg:#ff79c6,current_fg:#bd93f9,info:#ffb86c,marker:#6272a4,pointer:#50fa7b,spinner:#50fa7b
            )
            if ($selected | is-not-empty) {
                ^nu -c ($selected)
            } else {
                null
            }
        }
        def --env dir_fuzzy [] {
            let selected = (
                fd --type directory
                | ^sk --preview 'eza --tree --no-permissions --no-filesize --no-user --no-time --only-dirs {}' --height 40% --layout=reverse --color=fg:#f8f8f2,bg:#282a36,current_bg:#ff79c6,current_fg:#bd93f9,info:#ffb86c,marker:#6272a4,pointer:#50fa7b,spinner:#50fa7b
            )
            cd $selected
        }
        def find_fuzzy [] {
            # Find non-hidden text files with matches for any content and select one via fuzzy search
            let selected = (
                ^fd --type file --no-hidden -X rg -l --files-with-matches .
                | lines
                | sk --format { $in }
                    --height 40%
                    --layout=reverse
                    --preview { open $in | bat --color=always --line-range :50 }
                    --color=fg:#f8f8f2,bg:#282a36,current_bg:#ff79c6,current_fg:#bd93f9,info:#ffb86c,marker:#6272a4,pointer:#50fa7b,spinner:##50fa7b
            )
            if ($selected | is-not-empty) {
                ^$env.EDITOR $selected
            }
        }

        $env.config = {
          keybindings: [
            {
              name: history_fuzzy
              modifier: control
              keycode: char_r
              mode: [emacs, vi_insert, vi_normal]
              event: [
                {
                  send: executehostcommand
                  cmd: "history_fuzzy"
                }
              ]
            }
            {
              name: dir_fuzzy
              modifier: alt
              keycode: char_c
              mode: [emacs, vi_insert, vi_normal]
              event: [
                {
                  send: executehostcommand
                  cmd: "dir_fuzzy"
                }
              ]
            }
            {
              name: history_fuzzy
              modifier: control
              keycode: char_t
              mode: [emacs, vi_insert, vi_normal]
              event: [
                {
                  send: executehostcommand
                  cmd: "find_fuzzy"
                }
              ]
            }
          ]
        }
      '';
    };
  };
}
