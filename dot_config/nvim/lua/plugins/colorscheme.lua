return {
  -- Configure LazyVim to use rose-pine
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      variant = "moon", -- auto, main, moon, or dawn
      dark_variant = "moon",
      bold_vert_split = false,
      dim_inactive_windows = false, -- CRITICAL: prevent solid background on inactive windows
      disable_background = false, -- Keep false to use styles.transparency
      disable_float_background = false,
      disable_italics = false,

      styles = {
        bold = true,
        italic = true,
        transparency = true, -- NEW API: enables uniform transparency
      },

      -- Change specific vim highlight groups
      highlight_groups = {
        ColorColumn = { bg = "rose" },
        CursorLine = { bg = "foam", blend = 10 },
        StatusLine = { fg = "love", bg = "love", blend = 10 },
      },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd("colorscheme rose-pine")

      -- Additional transparency settings for uniformity
      vim.cmd([[
        highlight Normal guibg=NONE ctermbg=NONE
        highlight NormalNC guibg=NONE ctermbg=NONE
        highlight NormalFloat guibg=NONE ctermbg=NONE
        highlight NonText guibg=NONE ctermbg=NONE
      ]])

      -- Set popup opacity
      vim.opt.winblend = 0 -- Keep popups opaque for readability
      vim.opt.pumblend = 10 -- Slight transparency for completion menu
    end,
  },
}