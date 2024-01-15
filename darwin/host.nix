{...}: {
  # TODO: Add nix settings
  services.nix-daemon.enable = true;

  programs.zsh.enable = true;

  #homebrew = {
  #  enable = true;
  #  autoUpdate = true;
  #  casks = [
  #    "outlook"
  #    "iina"
  #  ];
  #};
}
