{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.features.desktop.coding;
in
{
  options.features.desktop.coding.enable = mkEnableOption "install coding related stuff";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bruno
      insomnia
    ];

    programs.zed-editor = {
      enable = true;
      userSettings = {
        features = {
          inline_prediction_provider = "zed";
          edit_prediction_provider = "zed";
          copilot = false;
        };
        telemetry = {
          metrics = false;
        };
        lsp = {
          rust_analyzer = {
            binary = {
              path_lookup = true;
            };
          };
        };
        languages = {
          Nix = {
            language_servers = [ "nixd" ];
            formatter = {
              external = {
                command = "alejandra";
                arguments = [
                  "-q"
                  "-"
                ];
              };
            };
          };
          Python = {
            language_servers = [ "pyright" ];
            formatter = {
              external = {
                command = "black";
                arguments = [ "-" ];
              };
            };
          };
        };
        assistant = {
          version = "2";
          default_model = {
            provider = "zed.dev";
            model = "claude-3-5-sonnet-latest";
          };
        };
        language_models = {
          anthropic = {
            version = "1";
            api_url = "https://api.anthropic.com";
          };
          openai = {
            version = "1";
            api_url = "https://api.openai.com/v1";
          };
          ollama = {
            api_url = "http://localhost:11434";
          };
        };
        ssh_connections = [
          {
            host = "152.53.85.162";
            nickname = "m3-atlas";
            args = [
              "-i"
              "~/.ssh/m3tam3re"
            ];
          }
          {
            host = "95.217.189.186";
            port = 2222;
            nickname = "self-host-playbook";
            args = [
              "-i"
              "~/.ssh/self-host-playbook"
            ];
            "projects" = [
              {
                paths = [ "/etc/nixos/current-systemconfig" ];
              }
            ];
          }
        ];
        auto_update = false;
        format_on_save = "on";
        vim_mode = true;
        load_direnv = "shell_hook";
        theme = "Dracula";
        buffer_font_family = "FiraCode Nerd Font";
        ui_font_size = 16;
        buffer_font_size = 16;
        show_edit_predictions = true;
      };
    };
  };
}
