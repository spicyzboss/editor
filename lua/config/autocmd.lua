local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opt = vim.opt

autocmd({ "BufNewFile", "BufRead", "BufNew" }, {
  pattern = "*.wgsl",
  callback = function()
    vim.bo.filetype = "wgsl"
  end,
})

-- autocmd({ "BufNewFile", "BufRead", "Bufnew" }, {
--   pattern = "*.json",
--   callback = function()
--     vim.bo.filetype = "jsonc"
--   end,
-- })

autocmd("FileType", {
  pattern = {
    "vim",
    "html",
    "css",
    "json",
    "javascript",
    "javascriptreact",
    "markdown.mdx",
    "typescript",
    "typescriptreact",
    "lua",
    "sh",
    "zsh",
    "fish",
    "rust",
  },
  callback = function()
    opt.shiftwidth = 2
    opt.softtabstop = 2
    opt.tabstop = 2
  end,
})

autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.signcolumn = "no"
  end,
})

