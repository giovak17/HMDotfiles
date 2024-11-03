
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          mason = false,
        },
        ruff = {
          mason = false,
        },
      },
    },
  }

}

