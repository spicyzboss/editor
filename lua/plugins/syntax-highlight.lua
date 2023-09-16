return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "windwp/nvim-ts-autotag" }
  },
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  opts = {
    autotag = {
      enable = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
    highlight = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
