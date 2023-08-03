return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.2",
  cmd = "Telescope",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
  opts = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown(),
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)

    telescope.load_extension("ui-select")
  end,
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
    { "<leader>fb", "<cmd>Telescope buffers show_all_buffers=true<CR>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Pages" },
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Recent" },
    { "<leader>:", "<cmd>Telescope command_history<CR>", desc = "Command History" },
  },
}
