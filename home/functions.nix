{
  rationalise-dot = ''
    set -l buffer (commandline -b)
    if string match -qr ".*\.\.\$" $buffer
        commandline -b -i "/.."
        #set -l new_length (string length (commandline -b))
        #commandline -C $new_length
      else
        commandline -b -i "."
      end
  '';
  pad = "curl --netrc-file ~/.config/.netrc -X DELETE \"https://arul.io/$argv[1]\"";
  send = "curl --netrc-file ~/.config/.netrc -d \"user=consumer&url=$argv[1]\" \"https://notif-server.arul.io/msg\"";
  sendhist = "curl --netrc-file ~/.config/.netrc \"https://notif-server.arul.io/history/consumer\"";
  fzfp = ''
    fzf --reverse --inline-info --preview="if test (file --mime {} | string match -r 'binary');
            echo '{} is a binary file';
        else
            highlight --style base16/nord -O ansi -l {} ||
            cat {} ^/dev/null | head -500;
        end" --bind '?:toggle-preview' --tabstop=1 --ansi --delimiter / --with-nth -1
  '';
  dots = "fe ~/nix";
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
  run = "nix run nixpkgs#$argv[1] -- $argv[2..-1]";
  clean = "nix-collect-garbage -d && sudo -i nix-collect-garbage -d";
}

