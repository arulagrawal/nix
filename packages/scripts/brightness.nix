{ writeShellApplication, pkgs, ... }:

writeShellApplication {
  name = "brightness";
  runtimeInputs = [ pkgs.ddcutil ];
  meta.description = ''
    Brightness control on monitor
  '';
  text = ''
    # obtain the special value "10" from `ddcutil capabilities`
    case "$1" in 
      "get")
        ddcutil getvcp 10 -t | cut --delimiter=" " --fields 4;;
      "set")
        ddcutil setvcp 10 "$2";;
      "*")
        echo "please choose either brightness get or brightness set <value>";;
    esac
  '';
}
