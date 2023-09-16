return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", "CmdlineEnter" },
    dependencies = {
      { "williamboman/mason.nvim", cmd = "Mason", build = ":MasonUpdate" },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function(_, _) end,
      },
      { "nvim-lua/lsp-status.nvim" },
    },
    opts = {
      servers = {
        lua_ls = {
          settings = { Lua = { diagnostics = { globals = { "vim" } } } },
        },
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                },
              },
            },
          },
        },
        rust_analyzer = {},
        gopls = {
          settings = {
            gofumpt = true,
            gopls = {
              experimentalPostfixCompletions = true,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
            },
          },
          init_options = {
            usePlaceholders = true,
          },
        },
      },
    },
    config = function(_, opts)
      require("mason").setup({
        ui = {
          border = "rounded",
          width = 0.8,
          height = 0.8,
        },
      })
      local mason_lspconfig = require("mason-lspconfig")
      local lsp_config = require("lspconfig")
      local lsp_status = require("lsp-status")
      lsp_status.register_progress()
      lsp_status.config({
        indicator_errors = "",
        indicator_warnings = "",
        indicator_info = "",
        indicator_hint = "",
        indicator_ok = "",
        -- status_symbol = "󱌢",
        status_symbol = "",
        show_filename = false,
      })

      local lsp_capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities(),
        lsp_status.capabilities
      )

      local lsp_attach = function(client, bufnr)
        lsp_status.on_attach(client)
        local key_opts = { buffer = bufnr, remap = false }

        local function show_documentation()
          local filetype = vim.bo.filetype
          if vim.tbl_contains({ "vim", "help" }, filetype) then
            vim.cmd("h " .. vim.fn.expand("<cword>"))
          elseif vim.tbl_contains({ "man" }, filetype) then
            vim.cmd("Man " .. vim.fn.expand("<cword>"))
          elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
            require("crates").show_popup()
          else
            vim.lsp.buf.hover()
          end
        end

        vim.keymap.set("n", "K", show_documentation, key_opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, key_opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, key_opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, key_opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, key_opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, key_opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, key_opts)
        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, key_opts)
        vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, key_opts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, key_opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, key_opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, key_opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, key_opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, key_opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, key_opts)
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format({ async = true, timeout = 5000 })
        end, key_opts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, key_opts)

        if client.name ~= "null-ls" and client.resolved_capabilities.document_formatting then
          client.server_capabilities.documentFormattingProvider = false
        end
      end

      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          { border = "rounded" }
        ),
      }

      mason_lspconfig.setup_handlers({
        function(server_name)
          lsp_config[server_name].setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            handlers = handlers,
            settings = opts.servers[server_name] and opts.servers[server_name].settings or {},
          })
        end,
      })

      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
        },
        severity_sort = true,
        float = {
          focusable = true,
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    },
    config = function(_, opts)
      local crates = require("crates")
      local key_opts = { silent = true }
      crates.setup(opts)

      vim.keymap.set("n", "<leader>ct", crates.toggle, key_opts)
      vim.keymap.set("n", "<leader>cr", crates.reload, key_opts)

      vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, key_opts)
      vim.keymap.set("n", "<leader>cf", crates.show_features_popup, key_opts)
      vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, key_opts)

      vim.keymap.set("n", "<leader>cu", crates.update_crate, key_opts)
      vim.keymap.set("v", "<leader>cu", crates.update_crates, key_opts)
      vim.keymap.set("n", "<leader>ca", crates.update_all_crates, key_opts)
      vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, key_opts)
      vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, key_opts)
      vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, key_opts)

      vim.keymap.set("n", "<leader>ce", crates.expand_plain_crate_to_inline_table, key_opts)
      vim.keymap.set("n", "<leader>cE", crates.extract_crate_into_table, key_opts)

      vim.keymap.set("n", "<leader>cH", crates.open_homepage, key_opts)
      vim.keymap.set("n", "<leader>cR", crates.open_repository, key_opts)
      vim.keymap.set("n", "<leader>cD", crates.open_documentation, key_opts)
      vim.keymap.set("n", "<leader>cC", crates.open_crates_io, key_opts)
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = { "BufReadPre", "BufNewFile", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "mtoohey31/cmp-fish",
      "chrisgrieser/cmp-nerdfont",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
            == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 20,
            preset = "codicons",
            ellipsis_char = "...",
            before = function(entry, vim_item)
              -- vim_item.menu = (vim_item.menu ~= nil) and string.sub(vim_item.menu, 1, 20) .. ((string.len(vim_item.menu) > 20) and "..." or "")
              vim_item.menu = ""
              return vim_item
            end,
          }),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1, max_item_count = 30 },
          { name = "luasnip", priority = 5, keyword_length = 2 },
          { name = "buffer", priority = 10, keyword_length = 3 },
          { name = "path", priority = 2 },
          { name = "fish" },
          { name = 'orgmode' },
          { name = "calc" },
          { name = "crates" },
          { name = "nerdfont" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Esc>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        matching = {
          disallow_fuzzy_matching = false,
        },
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" },
        }, {
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        root_dir = require("null-ls.utils").root_pattern(
          ".null-ls-root",
          ".neoconf.json",
          "Makefile",
          ".git"
        ),
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.fixjson,
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.formatting.gofmt,
          -- null_ls.builtins.formatting.prismaFmt,
        },
        on_attach = function(client, bufnr)
          if client.name == "null-ls" and client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            -- vim.api.nvim_create_autocmd("BufWritePre", {
            --   group = augroup,
            --   buffer = bufnr,
            --   callback = function()
            --     vim.lsp.buf.format({ async = false })
            --   end,
            -- })
          end
        end,
      })

      -- null_ls.builtins.formatting.rustfmt.with({
      --   extra_args = function(params)
      --     local Path = require("plenary.path")
      --     local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")
      --
      --     if cargo_toml:exists() and cargo_toml:is_file() then
      --       for _, line in ipairs(cargo_toml:readlines()) do
      --         local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
      --         if edition then
      --           return { "--edition=" .. edition }
      --         end
      --       end
      --     end
      --     return { "--edition=2021" }
      --   end,
      -- })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
    opts = {
      filetypes = {
        ["*"] = false,
        javascript = true,
        typescript = true,
        typescriptreact = true,
        lua = true,
        rust = true,
        c = true,
        ["c#"] = true,
        java = true,
        ["c++"] = true,
        go = true,
        python = true,
      },
      panel = {
        layout = {
          position = "right",
          ratio = 0.4,
        },
      },
    },
  },
}
