{
  pkgs,
  lib,
  ...
}: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
        # Theme
        gruvbox

        # Plugins
        ale
        vim-nix
        fzf-vim
        nvim-cmp
        lualine-nvim
        plenary-nvim # Needed for git-worktree-nvim
        vim-commentary
        bufferline-nvim
        nvim-web-devicons
        git-worktree-nvim
        indent-blankline-nvim-lua

        # Nvim treesitter.
        nvim-treesitter
        nvim-treesitter-context
        nvim-treesitter.withAllGrammars

        # Completion.
        nvim-cmp
        cmp-git
        cmp-spell
        cmp-vsnip
        cmp-path
        cmp-buffer
        cmp-cmdline
        cmp-nvim-lsp
        cmp-dictionary
        lspkind-nvim
        nvim-lspconfig
        friendly-snippets
        vim-vsnip
      ];

      extraPackages = with pkgs; [
        # Language Servers
        nil
        pyright
        lua-language-server
        marksman
      ];

      extraLuaConfig = lib.strings.concatStrings [
        (builtins.readFile ./lua/ale.lua)
        (builtins.readFile ./lua/init.lua)
        (builtins.readFile ./lua/nvim-cmp.lua)
        (builtins.readFile ./lua/lualine.lua)
        (builtins.readFile ./lua/bufferline.lua)
        (builtins.readFile ./lua/treesitter.lua)
        (builtins.readFile ./lua/git-worktree.lua)
        (builtins.readFile ./lua/indent-blankline.lua)
      ];
    };
  };

  xdg = {
    enable = true;
    configFile = {
      "nvim/after/ftplugin" = {
        source = ./after/ftplugin;
        recursive = true;
      };
    };
  };
}
