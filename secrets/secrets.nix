let
  arul = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINYdQ5b3KP0ejFGajR9m+9gXAC5rhTeJFsu0gTdCqivu email@arul.io";
  users = [ arul ];

  refrigerator = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPbO8B3dMVCdP1hP27X9s5FBJXGTFTKTx9Vxc5Husmd";
  kettle = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINHmGt+HJZ5tyPa6aYHNV6aqOx5fyYAQ5i91W1fvSIbB";
  oven = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP+4JtVo9WcmqR02yhLx4fPYhwuZDLMon3xR4Vsa/Rpk";
  systems = [ kettle refrigerator oven ];
in
{
  "notif.age".publicKeys = users ++ [ refrigerator ];
  "restic.age".publicKeys = users ++ systems;
}
