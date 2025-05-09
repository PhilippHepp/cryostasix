{ pkgs, ... }:
{
  imports = [
    ./fish.nix
    ./skim.nix
    ./nitch.nix
    ./nushell.nix
    ./secrets.nix
    ./starship.nix
    ./zellij.nix
  ];

  programs.carapace = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    extraOptions = [
      "-l"
      "--icons"
      "--git"
      "-a"
    ];
  };

  programs.lf = {
    enable = true;
    settings = {
      preview = true;
      drawbox = true;
      hidden = true;
      icons = true;
      theme = "Dracula";
      previewer = "bat";
    };
  };

  home.packages = with pkgs; [
    agenix-cli
    alejandra
    bc
    comma
    coreutils
    devenv
    fd
    gcc
    go
    htop
    httpie
    jq
    just
    lazygit
    llm
    lf
    nix-index
    nushellPlugins.skim
    progress
    ripgrep
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    rocmPackages.rocm-runtime
    tldr
    trash-cli
    unimatrix
    unzip
    vulkan-tools
    wttrbar
    wireguard-tools
    yazi
    zip
  ];
}
