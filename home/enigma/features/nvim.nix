{pkgs, ...}: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      vimdiffAlias = true;
      package = pkgs.inputs.flim.flim;
    };

    zsh = {
      shellAliases = {
        vim = "TERM=screen-256color vim";
        nvim = "TERM=screen-256color nvim";
      };
    };
  };
}
