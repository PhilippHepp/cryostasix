{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.zellij;
in {
  options.features.cli.zellij.enable = mkEnableOption "enable tmux";

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
    };
  };
}
