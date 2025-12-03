return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    opts = {
      -- Enable rendering by default
      enabled = true,
      -- Render in normal, visual, and command modes
      render_modes = { "n", "v", "c" },
      -- Maximum file size to render (10MB default)
      max_file_size = 10.0,
      -- Anti-conceal configuration to prevent treesitter errors
      anti_conceal = {
        enabled = false, -- Disable anti-conceal to avoid treesitter yield errors
      },
      -- Heading configuration
      heading = {
        enabled = true,
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      -- Code block configuration
      code = {
        enabled = true,
        sign = true,
        style = "full",
        width = "block",
        left_pad = 0,
        right_pad = 0,
      },
      -- Checkbox configuration
      checkbox = {
        enabled = true,
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰱒 " },
      },
      -- Bullet list configuration
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
    },
    config = function(_, opts)
      -- Wrap treesitter parsing to prevent yield errors
      local ok, render_markdown = pcall(require, "render-markdown")
      if ok then
        render_markdown.setup(opts)
      else
        vim.notify("Failed to load render-markdown", vim.log.levels.ERROR)
      end

      -- Keybindings
      vim.keymap.set("n", "<leader>mr", ":RenderMarkdown toggle<CR>", { desc = "Toggle Markdown Rendering" })
    end,
  },
}
