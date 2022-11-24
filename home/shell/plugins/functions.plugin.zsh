#   ████                            ██   ██
#  ░██░                            ░██  ░░
# ██████ ██   ██ ███████   █████  ██████ ██  ██████  ███████   ██████
#░░░██░ ░██  ░██░░██░░░██ ██░░░██░░░██░ ░██ ██░░░░██░░██░░░██ ██░░░░
#  ░██  ░██  ░██ ░██  ░██░██  ░░   ░██  ░██░██   ░██ ░██  ░██░░█████
#  ░██  ░██  ░██ ░██  ░██░██   ██  ░██  ░██░██   ░██ ░██  ░██ ░░░░░██
#  ░██  ░░██████ ███  ░██░░█████   ░░██ ░██░░██████  ███  ░██ ██████
#  ░░    ░░░░░░ ░░░   ░░  ░░░░░     ░░  ░░  ░░░░░░  ░░░   ░░ ░░░░░░

pa() {
    [ ! -f "$1" ] && echo "give a file name" && return 1
    curl --netrc-file ~/.config/.netrc -sF "file=@$1" "https://arul.io" | tee >(pbcopy)
}

pad() {
    curl --netrc-file ~/.config/.netrc -X DELETE "https://arul.io/$1"
}

send() {
    curl --netrc-file ~/.config/.netrc -d "msg=$1" "https://notif-server.arul.io/msg"
}

#fzf with preview options
fzfp() {
    fzf --reverse --inline-info --preview='[[ $(file --mime {}) =~ binary ]] &&
                  echo {} is a binary file ||
                  highlight --style base16/nord -O ansi -l {} ||
                  cat {} 2> /dev/null | head -500' --bind '?:toggle-preview' --tabstop=1 --ansi --delimiter / --with-nth -1
}

#quick lookup for my config files
dots() {
    find ~/nix -type f | awk '!/git|after|lua|.DS_Store/'| fzfp | xargs $EDITOR;
}

dec2bin () {
    echo "obase=2; $1" | bc
}

bin2dec () {
    echo "ibase=2; $1" | bc
}

hex2dec() {
    echo $((16#$1));
}

dec2hex() {
    echo "obase=16; $1" | bc;
}

hex2bin() {
    echo "obase=2; ibase=16; $1" | bc;
}

bin2hex() {
    echo "obase=16; ibase=2; $1" | bc;
}

c() {
    if [ $# -eq 0 ]; then
        clear
    elif [ -d "$1" ]; then
        cd "$1"
    elif [ -f "$1" ]; then
        cat "$1"
    fi
}

shorten() {
    curl -F"shorten=$*" https://0x0.st
}

archive() {
    local format="$1"
    local output="$2"
    local input=( "${@:3}" )
    case "$format" in
        tar )
            tar -czvf "${output}.tar.gz" "${input[@]}";;
        7z )
            7za a "${output}.7z" "${input[@]}";;
    esac
}

swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}

comp() {
    [ -f "a.out" ] && rm a.out
    g++ -std=c++2a $1
    ./a.out
    rm a.out
}

mkcd() {
    if [ ! -n "$1" ]; then
        echo "Enter a directory name"
    elif [ -d $1 ]; then
        echo "'$1' already exists"
    else
        mkdir -p "$1" && cd "$1"
    fi
}

cl() {
    cd "$@" && exa
}

'$'() {
    "${@}"
}

update() {
    echo "Updating nix-darwin and home-manager..."
    nix-channel --update
    echo "Updating nixpkgs..."
    sudo -i nix-channel --update
}

clean() {
    nix-collect-garbage -d
    sudo -i nix-collect-garbage -d
}
