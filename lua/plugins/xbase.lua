return {
  "xbase-lab/xbase",
  build = "make install", -- or "make install && make free_space" (not recommended, longer build time)
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("xbase").setup({}) -- see default configuration bellow
  end,
}
