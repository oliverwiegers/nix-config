{pkgs, ...}: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      vimdiffAlias = true;
      package = pkgs.inputs.flim.flim;
    };
  };
}
