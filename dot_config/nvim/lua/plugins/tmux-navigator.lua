return {
  "christoomey/vim-tmux-navigator",
  lazy = false, -- Load immediately for terminal mode navigation
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    -- Normal mode mappings only - terminal mode handled in config/keymaps.lua
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", mode = "n", desc = "Navigate Left" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", mode = "n", desc = "Navigate Down" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", mode = "n", desc = "Navigate Up" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", mode = "n", desc = "Navigate Right" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", mode = "n", desc = "Navigate Previous" },
  },
  init = function()
    -- Disable tmux navigator when zooming the Neovim pane
    vim.g.tmux_navigator_disable_when_zoomed = 1
    -- Don't save position when switching panes
    vim.g.tmux_navigator_save_on_switch = 2
  end,
}