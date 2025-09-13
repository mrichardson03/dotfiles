return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ruff = {
        init_options = {
          settings = {
            logLevel = "info",
          },
        },
      },
      terraformls = {},
    },
  },
}
