{
  rationalise-dot = ''
    set -l buffer (commandline -b)
    if string match -qr ".*\.\." $buffer
        commandline -b -a "/.."
      else
        commandline -b -a "."
      end
    set -l new_length (string length (commandline -b))
    commandline -C $new_length
  '';
  pa = ''
    if not test -f $argv[1]
        echo "give a file name"
        return 1
    end

    curl --netrc-file ~/.config/.netrc -sF "file=@$argv[1]" "https://arul.io" | pbcopy
  '';
  pad = "curl --netrc-file ~/.config/.netrc -X DELETE \"https://arul.io/$argv[1]\"";
  send = "curl --netrc-file ~/.config/.netrc -d \"msg=$argv[1]\" \"https://notif-server.arul.io/msg\"";
  fzfp = ''
    fzf --reverse --inline-info --preview="if test (file --mime {} | string match -r 'binary');
            echo '{} is a binary file';
        else
            highlight --style base16/nord -O ansi -l {} ||
            cat {} ^/dev/null | head -500;
        end" --bind '?:toggle-preview' --tabstop=1 --ansi --delimiter / --with-nth -1
  '';
  dots = "find ~/nix -type f | awk '!/git|after|lua|.DS_Store/'| fzfp | xargs $EDITOR";
  mkcd = ''
    # Check for arguments
    if test (count $argv) -eq 0
        echo "Please provide a directory name."
        return 1
    end

    # Create the directory
    mkdir -p $argv[1]
    if test $status -ne 0
        echo "Error creating directory $argv[1]."
        return 1
    end

    # Change to the directory
    cd $argv[1]
    if test $status -ne 0
        echo "Error changing to directory $argv[1]."
        return 1
    end
  '';
  try = ''
    set -l packages
    for i in $argv
            set packages $packages "nixpkgs#$i"
        end
    nix shell $packages
  '';
  clean = "nix-collect-garbage -d && sudo -i nix-collect-garbage -d";
}
