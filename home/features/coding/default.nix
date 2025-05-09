{pkgs, ...}: {
  home.packages = with pkgs; [
    devpod
    devpod-desktop
    code2prompt
    (python3.withPackages (ps:
      with ps; [
        pip
        # Scientific packages
        numba
        numpy
        openai-whisper
        torch
        srt
      ]))
    nixd
    alejandra
    tailwindcss
    tailwindcss-language-server
  ];
}
