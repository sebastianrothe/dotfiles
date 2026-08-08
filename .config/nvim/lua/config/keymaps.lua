vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<cr>", {
  desc = "Save file",
})

map("n", "<leader>q", "<cmd>quit<cr>", {
  desc = "Quit",
})

map("n", "<leader>f", function()
  vim.lsp.buf.format({
    async = true,
  })
end, {
  desc = "Format file",
})
