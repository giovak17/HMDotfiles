return {
  -- add gruvbox
  {
    "aktersnurra/no-clown-fiesta.nvim",
    opts = {
      transparent = true,
    },
  },
  {
    "catppuccin/nvim",
    init = function()
      require("catppuccin").setup({ transparent_background = true })
    end,
    opts = {
      transparent = true,
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "no-clown-fiesta",
      --colorscheme = "catppuccin-mocha",
    },
  },
}
