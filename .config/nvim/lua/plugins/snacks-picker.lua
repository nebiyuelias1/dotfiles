-- lua/plugins/snacks-picker.lua
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = { hidden = true, exclude = { ".git" } },
        grep = { hidden = true, exclude = { ".git" } },
      },
    },
  },
}
