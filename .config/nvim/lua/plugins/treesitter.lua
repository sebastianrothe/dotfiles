local languages = {
  "bash",
  "css",
  "html",
  "java",
  "javascript",
  "json",
  "jsonc",
  "lua",
  "markdown",
  "markdown_inline",
  "svelte",
  "tsx",
  "typescript",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",

    lazy = false,

    build = ":TSUpdate",

    config = function()
      require("nvim-treesitter").install(languages)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,

        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
