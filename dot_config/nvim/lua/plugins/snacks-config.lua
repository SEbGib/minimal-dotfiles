return {
  "folke/snacks.nvim",
  opts = {
    dashboard = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
    explorer = {
      -- Afficher les fichiers cachés par défaut (fichiers commençant par un point)
      hidden = true,
      -- Afficher aussi les fichiers ignorés par git
      ignored = false,
    },
  },
}
