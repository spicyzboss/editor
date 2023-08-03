return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  opts = function()
    return {
      options = {
        theme = "auto",
        icons_enabled = true,
        section_separators = "",
        component_separators = "",
        disabled_filetypes = {
          statusline = {
            "help",
            "startify",
            "dashboard",
            "packer",
            "neogitstatus",
            "NvimTree",
            "neo-tree",
            "Trouble",
            "alpha",
            "lir",
            "Outline",
            "spectre_panel",
            "toggleterm",
            "qf",
          },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = "  ",
              readonly = "",
              unnamed = "",
            },
          },
          -- {
          --   "diagnostics",
          --   sources = { "nvim_lsp" },
          --   symbols = { error = " ", warn = " ", info = " " },
          -- },
        },
        lualine_x = {
          "encoding",
          "filetype",
          function ()
            return require('lsp-status').status()
          end
        },
        lualine_y = { "progress" },
        lualine_z = {
          function()
            return " " .. os.date("%X")
          end,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
