{pkgs, ...}: {
  home.packages = with pkgs; [
    coq
    # coqPackages.coq-lsp
  ];
}
