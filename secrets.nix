let
  # SYSTEMS
  sierpinski-23 = "";
  penrose-512 = "";

  # USERS
  lstr-261 = "";
  users = [
    lstr-261
  ];

  systems = [
    sierpinski-23
    penrose-512
  ];
in
{
  "secrets/lstr-261-secrets.age".publicKeys = systems ++ users;
}
