{ pkgs, ... }:
{
  home.packages = with pkgs; [
    coq
    coqPackages.vscoq-language-server
  ];
}
