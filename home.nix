
{ pkgs, ... }:

{
  home.username = "adeline";
  home.homeDirectory = "/home/adeline";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish greeting ""
      fastfetch
    '';
  };

  home.packages = with pkgs; [
  ];
}

