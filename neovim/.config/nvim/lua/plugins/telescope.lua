return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    require('telescope').setup {
      defaults = {
        layout_config = {
          width = 0.75,
        },
        file_ignore_patterns = {
          "%.git/",
          "%vendor",
        },
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
          }
        }
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensionts = {
      }
    },
 }
