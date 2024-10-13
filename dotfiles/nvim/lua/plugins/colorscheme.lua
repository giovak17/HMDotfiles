return {
  -- add gruvbox
  {
    "aktersnurra/no-clown-fiesta.nvim",
    opts = {
      transparent = true,
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "no-clown-fiesta",
    },
  },
}
