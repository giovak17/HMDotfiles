vim.opt.clipboard = "unnamedplus"
-- New Keybinds
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "jk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "jk", "<Esc>", { noremap = true, silent = true })

-- Map <Tab> to change buffers / tabs
vim.api.nvim_set_keymap("n", "<Tab>", ":bn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bp<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "zz", ":NoiceDismis<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "zm", ":ZenMode<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
  "n",
  "<space>v",
  ":ToggleTerm size=40 dir=~ direction=vertical name=vertical<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<space>t",
  ":ToggleTerm size=15 dir=. direction=horizontal name=horizontal<CR>",
  { noremap = true, silent = true }
)

vim.opt.clipboard:append("unnamedplus")

return {
  { "rcarriga/nvim-notify", enabled = false },
  { "folke/zen-mode.nvim" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
      view = {
        side = "right",
        width = 30,
      },
    },
  },
}
