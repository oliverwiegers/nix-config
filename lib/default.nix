{
  pkgs,
  home-manager,
  system,
  lib,
  ...
}: rec {
  user = import ./user.nix {inherit pkgs home-manager system lib;};
  host = import ./host.nix {inherit pkgs home-manager system lib user;};
}
