return {
  {
    "wintermute-cell/gitignore.nvim",
    cmd = "Gitignore",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>gi", "<cmd>Gitignore<CR>", desc = "gitignore" },
    },
  },
  {
    "Equilibris/nx.nvim",
    cmd = "Telescope nx",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      nx_cmd_root = "pnpm nx",
    },
    keys = {
      { "<leader>gn", "<cmd>Telescope nx generators<CR>", desc = "NX generators" },
    },
  },
}
