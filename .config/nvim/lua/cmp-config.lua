local cmp = require'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
				-- vim.fn["vsnip#anonymous"](args.body)
        vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		-- Add tab support
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		})
	},

	-- Installed sources
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' },
		{ name = 'path' },
		{ name = 'buffer' },
	},
})
require('lsp_signature').setup({
  bind = true,
  handler_opts = {
    border = "rounded"
    }
  })
require'lspconfig'.gopls.setup{}
require'cmp'.setup {
  sources = {
    { name = 'nvim_lsp' }
  }
}
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lspconfig'.tsserver.setup {
  capabilities = capabilities,
}
