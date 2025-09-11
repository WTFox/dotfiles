local map = vim.keymap.set

local ns = { noremap = true, silent = true }
local s = { silent = true }

map("n", "<space>", "<Nop>")

-- movement
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-l>", "<C-w>l", s)
map("n", "<C-h>", "<C-w>h", s)
map("n", "<C-j>", "<C-w>j", s)
map("n", "<C-k>", "<C-w>k", s)
map("n", "L", ":bnext<CR>", s)
map("n", "H", ":bprevious<CR>", s)


map("n", "<leader>bd", "<cmd>bdelete<CR>", s)
map("n", "Q", "<cmd>q!<CR>", s)

--- save and quit
map("n", "<leader>w", "<cmd>w!<CR>", s)
map("n", "<leader>q", "<cmd>q<CR>", s)

-- tabs
map("n", "<leader>te", "<cmd>tabnew<CR>", s)

--- split windows and focus
map("n", "<leader>|", ":vsplit<CR><C-w>w", s)
map("n", "<leader>-", ":split<CR><C-w>w", s)

-- copy and paste
map("v", "<leader>p", '"_dP')
map("x", "y", [["+y]], s)

-- terminal
map("t", "<Esc>", "<C-\\><C-N>")

-- cd current dir
map("n", "<leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')

-- save
map("n", "<C-s>", ":w<CR>")

-- lsp
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", ns)
map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", ns)

-- diagnostics
map("n", "<leader>dn", "<cmd>lua vim.diagnostic.jump({count = 1})<CR>", ns)
map("n", "<leader>dp", "<cmd>lua vim.diagnostic.jump({count = -1})<CR>", ns)
map("n", "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", ns)
map("n", "<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>", ns)

-- files
map("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>")
map("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>")

map("n", "<leader>ff", "<cmd>FzfLua files<CR>")
map("n", "<leader><leader>", "<cmd>FzfLua files<CR>")
map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>")
map("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>")
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>")
map("n", "<leader>fc", "<cmd>FzfLua commands<CR>")
map("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>")
map("n", "<leader>fm", "<cmd>FzfLua marks<CR>")
map("n", "<leader>ft", "<cmd>FzfLua tabs<CR>")

map("n", "<leader>ha", require("miniharp").toggle_file)
map("n", "<leader>hc", require("miniharp").clear)
map("n", "<leader>l", require("miniharp").show_list)
map("n", "<C-n>", require("miniharp").next)
map("n", "<C-p>", require("miniharp").prev)

map({ "n", "x" }, "<leader>gy", require("gh-permalink").yank)
map("n", "<leader>ghp", require("Gitsigns").preview_hunk)
map("n", "<leader>ghb", require("Gitsigns").blame_line)
map("n", "<leader>ghr", require("Gitsigns").reset_hunk)
map("n", "<leader>gs", "<cmd>Git<CR>", ns)
map("n", "<leader>gd", "<cmd>Git diffthis<CR>", ns)
