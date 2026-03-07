vim.opt.winborder = "rounded"
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.swapfile = false
vim.o.signcolumn = "yes"
vim.o.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.o.termguicolors = true

vim.pack.add({
	--{ src = "https://github.com/EdenEast/nightfox.nvim" },
	--{ src = "https://github.com/vague-theme/vague.nvim" },
	{ src = "https://github.com/sainnhe/sonokai" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },
})

require "nvim-treesitter".setup({
	ensure_installed = { "python" },
	highlight = { enable = true }
})

-- sonokai but with vague's background color
vim.cmd("colorscheme sonokai")
vim.api.nvim_command('highlight Normal guibg=#141415 ctermbg=50')

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")


vim.lsp.enable({ "lua_ls", "ruff","basedpyright" })


vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

require "oil".setup({ view_options = { show_hidden = true, } })
vim.keymap.set('n', '<leader>e', ":Oil<CR>")


vim.keymap.set('n', '<leader>o', "<cmd>put = ''<CR>", { desc="Insert new line below" })
