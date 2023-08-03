return {
  {
    "xiyaowong/transparent.nvim",
    opts = {
      groups = {
        "Normal",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLineNr",
        "EndOfBuffer",
        "NormalFloat",
      },
      extra_groups = {},
      exclude_groups = {},
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "latte",
      background = { light = "latte", dark = "mocha" },
    },
    config = function(_, _)
      vim.cmd([[colorscheme catppuccin-latte]])
    end,
  },
}
