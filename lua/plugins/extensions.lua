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
  {
    "vuki656/package-info.nvim",
    event = { "BufRead package.json" },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      package_manager = "pnpm",
      hide_up_to_date = true,
      icons = {
        enable = true, -- Whether to display icons
        style = {
          up_to_date = "|  ", -- Icon for up to date dependencies
          outdated = "|  ", -- Icon for outdated dependencies
        },
      },
      colors = {
        up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
        outdated = "#d19a66", -- Text color for outdated dependency virtual text
      },
    },
    config = function(_, opts)
      local package_info = require("package-info")
      package_info.setup(opts)

      local key_opts = { silent = true, noremap = true }

      -- Show dependency versions
      vim.keymap.set("n", "<LEADER>ns", package_info.show, key_opts)

      -- Hide dependency versions
      vim.keymap.set("n", "<LEADER>nc", package_info.hide, key_opts)

      -- Toggle dependency versions
      vim.keymap.set("n", "<LEADER>nt", package_info.toggle, key_opts)

      -- Update dependency on the line
      vim.keymap.set("n", "<LEADER>nu", package_info.update, key_opts)

      -- Delete dependency on the line
      vim.keymap.set("n", "<LEADER>nd", package_info.delete, key_opts)

      -- Install a new dependency
      vim.keymap.set("n", "<LEADER>ni", package_info.install, key_opts)

      -- Install a different dependency version
      vim.keymap.set("n", "<LEADER>np", package_info.change_version, key_opts)
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
      require("colorizer").setup(opts)
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
}
