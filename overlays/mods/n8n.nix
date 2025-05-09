{prev}:
prev.n8n.overrideAttrs (oldAttrs: rec {
  version = "1.88.0";

  src = prev.fetchFromGitHub {
    owner = "n8n-io";
    repo = "n8n";
    rev = "n8n@${version}";
    hash = "sha256-bCRkwLYwb4gfxA1qMgMeCOc0zcu8bFAPlW577kVq6JY=";
  };

  pnpmDeps = prev.pnpm_10.fetchDeps {
    pname = oldAttrs.pname;
    inherit version src;
    hash = "sha256-cZzrkxGVyH0gKzV/+2XQdzvks6m0nwR4Z5QnSPlxEJI=";
  };

  nativeBuildInputs =
    builtins.map
    (input:
      if input == prev.pnpm_9.configHook
      then prev.pnpm_10.configHook
      else input)
    oldAttrs.nativeBuildInputs;
})
