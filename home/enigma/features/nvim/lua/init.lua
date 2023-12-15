-- Set colorscheme.
vim.cmd "colorscheme gruvbox"
vim.g.gruvbox_contrast_dark = "hard"

-- Set leader key to space.
vim.g.mapleader = " "

-- Disable mouse.
vim.opt.mouse = ""

-- Set theme for fzf preview using bat.
vim.fn.setenv("BAT_THEME", "gruvbox-dark")

vim.opt.list = true
vim.opt.listchars["tab"] = ">-"
vim.opt.listchars["trail"] = "~"
vim.opt.listchars["extends"] = ">"
vim.opt.listchars["precedes"] = "<"

-- Open fuzzy file finder if not a file is given at startup
if vim.fn.argc() == 0 then
    vim.defer_fn(
        function ()
            vim.cmd('Files')
        end,
        0
    )
end
