vim.g.python3_host_prog = "/home/cody/.local/share/virtualenvs/neovim/bin/python3"

local opt = vim.opt

opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.cursorline = true -- Enable highlighting of the current line
opt.wrap = false -- Disable line wrap
opt.scrolloff = 10 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context

-- Editing
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 2 -- Size of an indent
opt.softtabstop = 2
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftround = true -- Round indent
opt.smartindent = true -- Insert indents automatically
opt.autoindent = true
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

-- Search
opt.smartcase = true -- Don't ignore case with capitals
opt.ignorecase = true -- Ignore case
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit" -- preview incremental substitute

-- Visual
opt.termguicolors = true -- True color support
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.cmdheight = 0
opt.completeopt = "menu,menuone,noselect"
opt.showmode = false -- Dont show mode since we have a statusline
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.ruler = false -- Disable the default ruler
opt.smoothscroll = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- File Handling
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.autowrite = true
opt.autoread = true

-- Behavior
opt.errorbells = false
opt.autochdir = false
opt.iskeyword:append("-")
opt.selection = "exclusive"
opt.mouse = "a" -- Enable mouse mode
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.confirm = true -- Confirm to save changes before exiting modified buffer

-- Folding
opt.foldlevel = 99
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldmethod = "expr"
opt.foldtext = ""

-- Splits
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.winminwidth = 5 -- Minimum window width

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Formating
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"

opt.jumpoptions = "view"
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.spelllang = { "en" }
opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]

-- Command line completion
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Performance
opt.redrawtime = 10000 -- Applies to most highlighting
opt.maxmempattern = 20000 -- Max memory to use for pattern matching
