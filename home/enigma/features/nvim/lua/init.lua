-- Load local vimrc.
vim.opt.exrc = true

-- Set colorscheme.
vim.cmd "colorscheme gruvbox"
vim.g.gruvbox_contrast_dark = "hard"

-- Set leader key to space.
vim.g.mapleader = " "

-- Disable mouse.
vim.opt.mouse = ""

-- Modelines.
vim.opt.modeline = true
vim.opt.modelines = 5

-- Window splitting.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Indentation settings.
vim.opt.copyindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Disable buildin completion.
vim.opt.complete = ""
vim.opt.completeopt = ""

-- Highlight whitespaces.
vim.opt.list = true
vim.opt.listchars["tab"] = ">-"
vim.opt.listchars["trail"] = "~"
vim.opt.listchars["extends"] = ">"
vim.opt.listchars["precedes"] = "<"

-- Give more space for displaying messages.
vim.opt.cmdheight = 2

-- Switch buffers without saving.
vim.opt.hidden = true

-- Set encoding.
vim.opt.encoding = "utf-8"

-- Show linenumbers and current line relative.
vim.opt.relativenumber = true
vim.opt.number = true

-- Highlight search results.
vim.opt.hlsearch = true

-- Start searching by substring. vim.opt.incsearch = true

-- Expand tabs to spaces
vim.opt.expandtab = true

-- Use zsh as vim shell.
vim.opt.shell = "zsh"

-- Make Ctrl-a and Ctrl-x working with Base-10 numbers.
vim.opt.nrformats = "bin,hex,octal"

-- Enable persistent undo. Or in other words: Being able to undo changes even
-- if the file was closed.
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- Set cursorline.
vim.opt.cursorline = true

-- Set cursorcolumn.
vim.opt.cursorcolumn = true

-- A.L.E keybindings.
vim.keymap.set("n", "<Leader>an", ":AleNext<CR>", {silent=true})
vim.keymap.set("n", "<Leader>ap", ":ALEPrevious<CR>", {silent=true})

-- GoTo file under cursor.
vim.keymap.set("n", "gf", "<C-W>gf", {silent=true})

-- Save file as root.
vim.keymap.set('c', 'w!!', ':w ! sudo tee % > /dev/null')

-- Split navigation.
vim.keymap.set("n", "<Leader>-", ":split<CR>", {silent=true})
vim.keymap.set("n", "<Leader>v", ":vsplit<CR>", {silent=true})

-- Tab navigation.
vim.keymap.set("n", "<Leader>k", ":tabnext<CR>", {silent=true})
vim.keymap.set("n", "<Leader>j", ":tabprevious<CR>", {silent=true})

-- Mapping redo command to U.
vim.keymap.set("n", "<S-u>", ":redo<CR>", {silent=true})

-- Reset search pattern.
vim.keymap.set("n", "<C-l>", ":nohlsearch<CR><C-l>", {silent=true})

-- FZF commands.
vim.keymap.set("n", "<Tab><Tab>", ":Rg<CR>", {silent=true})
vim.keymap.set("n", "<Leader>b", ":Buffers<CR>", {silent=true})
vim.keymap.set("n", "<Leader><Space>", ":Files<CR>", {silent=true})
vim.keymap.set("n", "<Leader>gc", ":Commits<CR>", {silent=true})

-- Open fuzzy file finder if not a file is given at startup.
if vim.fn.argc() == 0 then
    vim.defer_fn(
        function ()
            vim.cmd('Files')
        end,
        0
    )
end
