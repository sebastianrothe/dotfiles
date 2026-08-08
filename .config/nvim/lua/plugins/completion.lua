return {
  {
    "saghen/blink.cmp",

    version = "1.*",

    event = "InsertEnter",

    opts = {
      keymap = {
        preset = "default",
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },

      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
      },
    },
  },
}
