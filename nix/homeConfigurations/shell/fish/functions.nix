{
  fzfp = ''
    fzf --reverse --inline-info --preview="if test (file --mime {} | string match -r 'binary');
            echo '{} is a binary file';
        else
            highlight --style base16/nord -O ansi -l {} ||
            cat {} ^/dev/null | head -500;
        end" --bind '?:toggle-preview' --tabstop=1 --ansi --delimiter / --with-nth -1
  '';
  dots = "find ~/nix -type f | awk '!/git|after|lua|.DS_Store/'| fzfp | xargs $EDITOR";
  try = ''
    set -l packages
    for i in $argv
            set packages $packages "nixpkgs#$i"
        end
    nix shell $packages
  '';
}
