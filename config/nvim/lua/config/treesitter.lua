local ok, treesitter = pcall(require, "nvim-treesitter")
if not ok then
  return
end

treesitter.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
