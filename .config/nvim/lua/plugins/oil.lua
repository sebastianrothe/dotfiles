return {
  {
    "stevearc/oil.nvim",

    cmd = "Oil",

    keys = {
      {
        "-",
        "<cmd>Oil<cr>",
        desc = "Open parent directory",
      },
    },

    opts = {
      view_options = {
        show_hidden = true,
      },
    },
  },
}
