return {
  {
    "neovim/nvim-lspconfig",

    config = function()
      vim.lsp.enable({
        "ts_ls",
        "svelte",
        "oxlint",
        "oxfmt",
        "jdtls",
      })
    end,
  },
}
