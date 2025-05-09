{pkgs, ...}: {
  # Define your custom packages here
  msty = pkgs.callPackage ./msty {};
  msty-sidecar = pkgs.callPackage ./msty-sidecar {};
  zellij-ps = pkgs.callPackage ./zellij-ps {};
  aider-chat-env = pkgs.callPackage ./aider-chat-env {};
  code2prompt = pkgs.callPackage ./code2prompt {};
  pomodoro-timer = pkgs.callPackage ./pomodoro-timer {};
}
