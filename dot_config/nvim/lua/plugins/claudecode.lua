return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  lazy = false, -- Load immediately to ensure server connection
  priority = 50, -- Load after snacks but before most plugins
  cmd = { "ClaudeCode", "ClaudeCodeSend", "ClaudeCodeAdd", "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny" },
  keys = {
    { "<leader>a", desc = "+AI/Claude" }, -- which-key group prefix
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = { "n", "v" }, desc = "Send to Claude" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Diff" },
    { "<leader>ar", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Reject Diff" },
  },
  opts = {
    server = {
      host = "127.0.0.1",
      port = 52225,
    },
  },
  config = function(_, opts)
    -- Setup the plugin
    require("claudecode").setup(opts)

    -- Navigation keys (Ctrl+h/j/k/l) are handled by vim-tmux-navigator
    -- This allows seamless navigation between Neovim windows, terminal buffers, and tmux panes
  end,
}
