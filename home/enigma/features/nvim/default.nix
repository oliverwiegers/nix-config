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
        dashboard-nvim
        bufferline-nvim
        nvim-web-devicons

        # Nvim cmp
        nvim-cmp
        cmp-path
        cmp-nvim-lsp
        cmp-buffer
        cmp-cmdline
        vim-vsnip
        nvim-lspconfig
      ];

      extraPackages = with pkgs; [
        # Language Servers
        nil
        pyright
        lua-language-server
      ];

      coc = {
        enable = true;
      };

      extraLuaConfig = lib.strings.concatStrings [
        (builtins.readFile ./lua/init.lua)
        (builtins.readFile ./lua/nvim-cmp.lua)
        (builtins.readFile ./lua/lualine.lua)
        (builtins.readFile ./lua/dashboard.lua)
        (builtins.readFile ./lua/bufferline.lua)
      ];

      # Quick porting for pre nix vim config.
      extraConfig = lib.strings.concatStrings [
        (builtins.readFile ./vimscript/init.vim)
        (builtins.readFile ./vimscript/ale.vim)
        (builtins.readFile ./vimscript/keybindings.vim)
      ];
    };
  };
}
