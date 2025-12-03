return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    require("dbee").install()
  end,
  config = function()
    require("dbee").setup({
      -- Optional: Add your database connections here
      -- sources = {
      --   require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
      --   require("dbee.sources").FileSource:new(vim.fn.stdpath("config") .. "/dbee/connections.json"),
      -- },
    })
  end,
  keys = {
    {
      "<leader>db",
      function()
        require("dbee").toggle()
      end,
      desc = "Toggle Dbee",
    },
    {
      "<leader>dbo",
      function()
        require("dbee").open()
      end,
      desc = "Open Dbee",
    },
    {
      "<leader>dbc",
      function()
        require("dbee").close()
      end,
      desc = "Close Dbee",
    },
  },
}
