{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (python3.withPackages (
      ps: with ps; [
        pip
        # Scientific packages
        numpy
      ]
    ))
    # nix related
    nixd
    nixpkgs-fmt
  ];
}
