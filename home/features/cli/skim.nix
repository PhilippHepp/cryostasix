{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.skim;
in {
  options.features.cli.skim.enable = mkEnableOption "enable skim fuzzy finder";

  config = mkIf cfg.enable {
    programs.skim = {
      enable = true;
      enableFishIntegration = true;
      defaultOptions = [
        "--preview='bat --color=always -n {}'"
        "--bind 'ctrl-/:toggle-preview'"
      ];
      defaultCommand = "fd --type f --exclude .git --follow --hidden";
      changeDirWidgetCommand = "fd --type d --exclude .git --follow --hidden";
    };
  };
}
