return {
  {
    "ibhagwan/fzf-lua",

    cmd = "FzfLua",

    keys = {
      {
        "<leader>ff",
        function()
          require("fzf-lua").files()
        end,
        desc = "Find files",
      },

      {
        "<leader>fg",
        function()
          require("fzf-lua").live_grep()
        end,
        desc = "Search project",
      },

      {
        "<leader>fb",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "Buffers",
      },

      {
        "<leader>fs",
        function()
          require("fzf-lua").lsp_document_symbols()
        end,
        desc = "Document symbols",
      },

      {
        "<leader>fr",
        function()
          require("fzf-lua").lsp_references()
        end,
        desc = "References",
      },
    },

    opts = {
      "max-perf",
    },
  },
}
