{
  # Garbage collect automatically every month
  nix.gc = {
    automatic = true;
    frequency = "monthly";
  };
}
