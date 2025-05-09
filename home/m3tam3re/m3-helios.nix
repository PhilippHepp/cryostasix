{
  imports = [
    ../common
    ../features/cli
    ./home-server.nix
  ];

  features = {
    cli = {
      fish.enable = true;
      fzf.enable = true;
      nitch.enable = true;
      secrets.enable = false;
      starship.enable = true;
    };
  };
}
