-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>e', ':Neotree toggle position=left<CR>', noremap = true, silent = true }, -- focus file explorer
    { '<leader>ngs', ':Neotree float git_status<CR>', noremap = true, silent = true }, -- open git status window
  },
  opts = {
    enable_git_status = true,
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_pattern = {
          '.git',
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      use_libuv_file_watcher = false,
    },
  },
}
