return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    "folke/snacks.nvim", -- Recommended for ask() and select()
  },
  config = function()
    -- Configuration via vim.g.opencode_opts
    vim.g.opencode_opts = {
      -- Auto-reload buffers edited by opencode
      auto_reload = true,
      -- Provider configuration (uses snacks by default)
      provider = {
        enabled = "snacks", -- Use snacks.terminal for integrated opencode
      },
    }

    -- Required for auto_reload
    vim.o.autoread = true
  end,
  keys = {
    -- OpenCode integration keymaps under <leader>a (AI menu)
    { "<leader>ao", function() require("opencode").toggle() end, mode = { "n", "t" }, desc = "Toggle OpenCode" },
    { "<leader>aa", function() require("opencode").ask("@this: ", { submit = true }) end, mode = { "n", "x" }, desc = "Ask OpenCode" },
    { "<leader>ax", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Execute OpenCode action…" },
    { "<leader>ap", function() require("opencode").prompt("@this") end, mode = { "n", "x" }, desc = "Add to OpenCode" },
    
    -- Command shortcuts
    { "<leader>ai", function() require("opencode").command("session.interrupt") end, desc = "OpenCode Interrupt" },
    { "<leader>an", function() require("opencode").command("session.new") end, desc = "OpenCode New Session" },
    { "<leader>al", function() require("opencode").command("session.list") end, desc = "OpenCode List Sessions" },
    { "<leader>as", function() require("opencode").command("session.share") end, desc = "OpenCode Share Session" },
    
    -- Quick prompts for code review and improvement
    { "<leader>ae", ":OpencodePrompt explain<cr>", mode = { "n", "x" }, desc = "OpenCode Explain" },
    { "<leader>ar", ":OpencodePrompt review<cr>", mode = { "n", "x" }, desc = "OpenCode Review" },
    { "<leader>at", ":OpencodePrompt test<cr>", mode = { "n", "x" }, desc = "OpenCode Test" },
    { "<leader>ad", ":OpencodePrompt document<cr>", mode = { "n", "x" }, desc = "OpenCode Document" },
    { "<leader>af", ":OpencodePrompt fix<cr>", mode = { "n", "x" }, desc = "OpenCode Fix" },
  },
}
