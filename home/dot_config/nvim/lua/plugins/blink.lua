return {
  "saghen/blink.cmp",
  opts = {
    -- Disable for specifc buffer types.
    -- https://cmp.saghen.dev/recipes.html#disable-per-filetype-buffer
    enabled = function()
      return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
    end,

    completion = {
      menu = {
        -- Disable automatically showing the menu while typing.
        -- Press `<C-space>` to show it manually
        -- https://cmp.saghen.dev/recipes.html#disable-or-delay-showing-completion-menu
        auto_show = false,
      },
    },
  },
}
