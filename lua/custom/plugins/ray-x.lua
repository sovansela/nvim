return {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },

  ft = { 'go', 'gomod' },

  opts = {
    gomodifytags_transform = 'camelcase',
  },

  config = function(_, opts)
    require('go').setup(opts)

    -- format on save (sync, safe)
    local group = vim.api.nvim_create_augroup('GoFormat', { clear = true })

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = group,
      pattern = '*.go',
      callback = function()
        require('go.format').goimports { async = false }
      end,
    })
  end,

  build = ':lua require("go.install").update_all_sync()',
}
