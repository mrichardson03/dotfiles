-- Set leader keys first
vim.g.mapleader = " "                   -- Leader key: space
vim.g.maplocalleader = " "              -- Local leader key: space

vim.cmd.colorscheme("sorbet")           -- Also good: unokai

-- Basic settings
vim.opt.number = true                   -- Line numbers
vim.opt.relativenumber = true           -- Relative line numbers
vim.opt.cursorline = true               -- Highlight current line
vim.opt.wrap = false                    -- Don't wrap lines
vim.opt.scrolloff = 10                  -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8               -- Keep 8 columns left/right of cursor

-- Default indentation
vim.opt.tabstop = 2                     -- Tab char = two spaces
vim.opt.shiftwidth = 2                  -- Intentation = two spaces
vim.opt.softtabstop = 2                 -- Soft tab stop = two spaces
vim.opt.expandtab = true                -- Use spaces instead of tabs
vim.opt.smartindent = true              -- Smart auto-indenting
vim.opt.autoindent = true               -- Copy indent from current line

-- Searching
vim.opt.ignorecase = true               -- Default search is case insensitve
vim.opt.smartcase = true                -- Case sensitive search if uppercase is used

-- Visual
vim.opt.termguicolors = true            -- Enable 24-bit colors
vim.opt.signcolumn = "yes"              -- Always show sign column
vim.opt.showmatch = true                -- Highlight matching brackets/parens
vim.opt.matchtime = 2                   -- How long to show matching brackets/parens

-- Display whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Behavior settings
vim.opt.backspace = "indent,eol,start"  -- Allow backspace over indentation, line breaks, start of insert mode
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
vim.out.mouse = "a"                     -- Enable mouse support

-- Split behavior
vim.opt.splitbelow = true               -- When horizontal splitting, new window goes below
vim.opt.splitright = true               -- When vertical splitting, new window goes to right

-- vim: ts=2 sw=2 sts=2 et
