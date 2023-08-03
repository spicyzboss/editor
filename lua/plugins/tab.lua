return {
  "romgrk/barbar.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  config = function(_, opts)
    require("barbar").setup(opts)
    local map = vim.api.nvim_set_keymap
    local key_opts = { noremap = true, silent = true }

    -- Move to previous/next
    map("n", "<A-[>", "<Cmd>BufferPrevious<CR>", key_opts)
    map("n", "<A-]>", "<Cmd>BufferNext<CR>", key_opts)
    -- Re-order to previous/next
    map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", key_opts)
    map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", key_opts)
    -- Goto buffer in position...
    map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", key_opts)
    map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", key_opts)
    map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", key_opts)
    map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", key_opts)
    map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", key_opts)
    map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", key_opts)
    map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", key_opts)
    map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", key_opts)
    map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", key_opts)
    map("n", "<A-0>", "<Cmd>BufferLast<CR>", key_opts)
    -- Pin/unpin buffer
    map("n", "<A-p>", "<Cmd>BufferPin<CR>", key_opts)
    -- Close buffer
    map("n", "<A-c>", "<Cmd>BufferClose<CR>", key_opts)
    -- Wipeout buffer
    --                 :BufferWipeout
    -- Close commands
    --                 :BufferCloseAllButCurrent
    --                 :BufferCloseAllButPinned
    --                 :BufferCloseAllButCurrentOrPinned
    --                 :BufferCloseBuffersLeft
    --                 :BufferCloseBuffersRight
    -- Magic buffer-picking mode
    map("n", "<C-p>", "<Cmd>BufferPick<CR>", key_opts)
    -- Sort automatically by...
    map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", key_opts)
    map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", key_opts)
    map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", key_opts)
    map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", key_opts)
  end,
  version = "^1.0.0",
}
