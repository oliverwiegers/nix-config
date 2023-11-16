-- Set colorscheme.
vim.cmd "colorscheme gruvbox"
vim.g.gruvbox_contrast_dark = "hard"

-- Set leader key to space.
vim.g.mapleader = " "

-- Disable mouse.
vim.opt.mouse = "" 

-- Set theme for fzf preview using bat.
vim.fn.setenv("BAT_THEME", "gruvbox-dark")
