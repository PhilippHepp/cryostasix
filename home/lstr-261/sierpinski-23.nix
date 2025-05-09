{
  imports = [
    ../common
    ../features/cli
    ./home-server.nix
  ];

  features = {
    cli = {
      nushell.enable = true;
      skim.enable = true;
      nitch.enable = true;
      secrets.enable = false;
      starship.enable = true;
    };
  };
}
