require("mason").setup()

-- removing "spectral" as it's broken install from cloning via ssh
-- instead of https
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls", "bashls", "dockerls", "eslint", "jsonls", "tsserver",
    "marksman", "pyright", "taplo", "terraformls", "tflint",
    "yamlls"
  },
  automatic_installation = false
})


local rust_tools = require("rust-tools")
local rust_opts = {
  tools = {
    autoSetHints = true,
    runnables = {
      use_telescope = true
    },
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    on_attach = function(_, bufnr)
    -- Hover actions
    vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
    -- Code action groups
    vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
    end,
    -- on_attach is a callback called when the language server attachs to the buffer
    -- on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy"
          },
        }
      }
    },
  }

rust_tools.setup(rust_opts)

local lsp_flags = {

  -- This is the default in Nvim 0.7+
  --
  debounce_text_changes = 150,
}

require('lspconfig')['pyright'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require('lspconfig')['tsserver'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require('lspconfig')['yamlls'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}
