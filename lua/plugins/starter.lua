return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    require("alpha")
    require("alpha.term")

    local dashboard = require("alpha.themes.dashboard")

    local width = 27
    local height = 15 -- two pixels per vertical space
    dashboard.section.terminal.command = "cat | "
      .. os.getenv("HOME")
      .. "/.config/fish/functions/art/thisisfine.sh"

    dashboard.section.terminal.width = width
    dashboard.section.terminal.height = height
    dashboard.section.terminal.opts.redraw = true

    dashboard.section.header.val = "  NEOVIM  "

    dashboard.section.buttons.val = {
      -- dashboard.button("e", "󰈔 " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "󰈞 " .. " Find file", ":Telescope find_files<CR>"),
      dashboard.button("t", "󰺮 " .. " Find text", ":Telescope live_grep<CR>"),
      dashboard.button(
        "c",
        " " .. " Config",
        ":cd " .. os.getenv("NVIMCFG") .. " | e init.lua<CR>"
      ),
      dashboard.button("m", "󰈸 " .. " Mason", ":Mason<CR>"),
      dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
      dashboard.button("q", "󰗼  Quit", ":qa<CR>"),
    }

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end

    dashboard.section.header.opts.hl = "AlphaShortcut"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "Type"

    dashboard.section.footer.val = "󰊤 spicyzboss"

    -- local fortune = require("alpha.fortune")
    -- dashboard.section.footer.val = fortune()

    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.terminal,
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    return dashboard.opts
  end,
  init = function()
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
