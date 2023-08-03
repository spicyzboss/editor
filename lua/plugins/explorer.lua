return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  opts = {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
    },
    window = {
      position = "right",
      width = 40,
      mappings = {
        ["h"] = "close_node",
        ["l"] = "open",
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  },
}
