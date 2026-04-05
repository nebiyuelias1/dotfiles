return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          -- 1. Disable Mason for this server so it doesn't
          --    try to use a 'standalone' installation.
          mason = false,
          -- 2. Use mise to execute the ruby-lsp gem
          --    installed in your current project version.
          cmd = { "mise", "x", "--", "ruby-lsp" },
        },
      },
    },
  },
}
