-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Exit insert mode with jk
keymap.set("i", "jk", "<ESC>", opts)

-- Window management (consistent with tmux)
keymap.set("n", "<leader>-", "<C-w>v", opts) -- split window vertically (side by side)
keymap.set("n", "<leader>_", "<C-w>s", opts) -- split window horizontally (top/bottom)
keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal size
keymap.set("n", "<leader>sx", ":close<CR>", opts) -- close current split window

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>", opts) -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", opts) -- previous tab

-- Symfony Development Shortcuts
keymap.set("n", "<leader>sc", ":!symfony console<CR>", { desc = "Symfony Console" })
keymap.set("n", "<leader>ss", ":!symfony serve -d<CR>", { desc = "Symfony Serve" })
keymap.set("n", "<leader>st", ":!symfony console doctrine:fixtures:load --no-interaction<CR>", { desc = "Load Fixtures" })
keymap.set("n", "<leader>sm", ":!symfony console make:", { desc = "Symfony Make..." })

-- PHP specific shortcuts
keymap.set("n", "<leader>pa", ":!php artisan<CR>", { desc = "PHP Artisan" })
keymap.set("n", "<leader>pc", ":!composer<CR>", { desc = "Composer" })

-- Git shortcuts
keymap.set("n", "<leader>gs", ":!git status<CR>", { desc = "Git Status" })
keymap.set("n", "<leader>ga", ":!git add .<CR>", { desc = "Git Add All" })
keymap.set("n", "<leader>gc", ":!git commit<CR>", { desc = "Git Commit" })
keymap.set("n", "<leader>gp", ":!git push<CR>", { desc = "Git Push" })

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", opts)

-- FZF-lua shortcuts
keymap.set("n", "<leader>ff", ":FzfLua files<CR>", { desc = "Find Files" })
keymap.set("n", "<leader>fg", ":FzfLua live_grep<CR>", { desc = "Live Grep" })
keymap.set("n", "<leader>fb", ":FzfLua buffers<CR>", { desc = "Find Buffers" })
keymap.set("n", "<leader>fh", ":FzfLua help_tags<CR>", { desc = "Help Tags" })
keymap.set("n", "<leader>fr", ":FzfLua oldfiles<CR>", { desc = "Recent Files" })
keymap.set("n", "<leader>fc", ":FzfLua commands<CR>", { desc = "Commands" })

-- Git with FZF
keymap.set("n", "<leader>gf", ":FzfLua git_files<CR>", { desc = "Git Files" })
keymap.set("n", "<leader>gb", ":FzfLua git_branches<CR>", { desc = "Git Branches" })
keymap.set("n", "<leader>gl", ":FzfLua git_commits<CR>", { desc = "Git Log" })

-- LSP shortcuts
keymap.set("n", "<leader>lr", ":FzfLua lsp_references<CR>", { desc = "LSP References" })
keymap.set("n", "<leader>ld", ":FzfLua lsp_definitions<CR>", { desc = "LSP Definitions" })
keymap.set("n", "<leader>ls", ":FzfLua lsp_document_symbols<CR>", { desc = "Document Symbols" })
keymap.set("n", "<leader>lw", ":FzfLua lsp_workspace_symbols<CR>", { desc = "Workspace Symbols" })

-- Colorizer toggle
keymap.set("n", "<leader>ct", ":ColorizerToggle<CR>", { desc = "Toggle Colorizer" })

-- Claude Code shortcuts (main config in plugins/claudecode.lua)
keymap.set("n", "<leader>ac", ":ClaudeCode<CR>", { desc = "Toggle Claude" })
keymap.set({ "n", "v" }, "<leader>as", ":ClaudeCodeSend<CR>", { desc = "Send to Claude" })
keymap.set("n", "<leader>ad", ":ClaudeCodeDiffAccept<CR>", { desc = "Accept Diff" })
keymap.set("n", "<leader>ar", ":ClaudeCodeDiffDeny<CR>", { desc = "Reject Diff" })

-- Terminal mode navigation for vim-tmux-navigator
-- These mappings exit terminal mode first, then navigate
keymap.set("t", "<C-h>", "<C-\\><C-n>:TmuxNavigateLeft<CR>", { silent = true, desc = "Navigate Left from Terminal" })
keymap.set("t", "<C-j>", "<C-\\><C-n>:TmuxNavigateDown<CR>", { silent = true, desc = "Navigate Down from Terminal" })
keymap.set("t", "<C-k>", "<C-\\><C-n>:TmuxNavigateUp<CR>", { silent = true, desc = "Navigate Up from Terminal" })
keymap.set("t", "<C-l>", "<C-\\><C-n>:TmuxNavigateRight<CR>", { silent = true, desc = "Navigate Right from Terminal" })
keymap.set("t", "<C-\\>", "<C-\\><C-n>:TmuxNavigatePrevious<CR>", { silent = true, desc = "Navigate Previous from Terminal" })

-- Optional: Quick exit from terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { silent = true, desc = "Exit Terminal Mode" })

-- Force terminal keymaps on all terminal buffers (including Claude Code)
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set("t", "<C-h>", "<C-\\><C-n>:TmuxNavigateLeft<CR>", { silent = true, buffer = bufnr })
    vim.keymap.set("t", "<C-j>", "<C-\\><C-n>:TmuxNavigateDown<CR>", { silent = true, buffer = bufnr })
    vim.keymap.set("t", "<C-k>", "<C-\\><C-n>:TmuxNavigateUp<CR>", { silent = true, buffer = bufnr })
    vim.keymap.set("t", "<C-l>", "<C-\\><C-n>:TmuxNavigateRight<CR>", { silent = true, buffer = bufnr })
    vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>:TmuxNavigatePrevious<CR>", { silent = true, buffer = bufnr })
    vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { silent = true, buffer = bufnr })
  end,
  desc = "Setup terminal navigation keymaps",
})