return {
  {
    -- Auto pairs
    "echasnovski/mini.pairs",
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  {
    -- Comments
    "echasnovski/mini.comment",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring" },
    },
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring()
            or vim.bo.commentstring
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },
  {
    -- Surround
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Vsual modes
        delete = "ds", -- Delete surroundng
        replace = "cs", -- Replace surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
      n_lines = 100,
    },
    config = function(_, opts)
      -- use gz mappings instead of s to prevent conflict with leap
      require("mini.surround").setup(opts)
    end,
  },
  {
    "echasnovski/mini.animate",
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
      require("mini.animate").setup(opts)
    end,
  },
  {
    "echasnovski/mini.move",
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
      require("mini.move").setup(opts)
    end,
  },
  {
    "echasnovski/mini.jump2d",
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
      require("mini.jump2d").setup(opts)
    end,
  },
}
