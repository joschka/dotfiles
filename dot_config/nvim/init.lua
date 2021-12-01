local function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

-- Plugins
local packer_bootstrap
local packer_install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
	packer_bootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		packer_install_path,
	})
end

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	use({
		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer",
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		commit = "b07ce47f02c7b12ad65bfb4da215c6380228a959",
		requires = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
	})

	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({
		"folke/trouble.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("trouble").setup()
		end,
	})

	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
	})

	use({
		"nvim-treesitter/playground",
	})

	use({
		"phaazon/hop.nvim",
		config = function()
			require("hop").setup()
		end,
	})
	use("mfussenegger/nvim-ts-hint-textobject")

	use("tpope/vim-commentary")

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})

	use({
		"shaunsingh/nord.nvim",
		config = function()
			vim.cmd("colorscheme nord")
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)

-- Settings
vim.g.mapleader = ","
vim.o.signcolumn = "yes:2"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.list = true
vim.opt.listchars = { tab = "▸ ", trail = "·" }

-- Telescope
map("n", "<leader>e", "<cmd>Explore<cr>")
map("n", "<leader>.", "<cmd>Telescope find_files<cr>")
map("n", "<leader><space>", "<cmd>Telescope buffers<cr>")
map("n", "<leader>m", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>t", "<cmd>lua require'telescope.builtin'.treesitter()<cr>")

-- Hopping
map("n", "h", "<cmd>lua require'hop'.hint_char2()<cr>")
map(
	"n",
	"s",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
)
map(
	"n",
	"S",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
)
map(
	"o",
	"s",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
)
map(
	"o",
	"S",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
)
vim.cmd("hi HopNextKey guifg=#ebcb8b")
vim.cmd("hi HopNextKey1 guifg=#ebcb8b")
vim.cmd("hi HopNextKey2 guifg=#ebcb8b")

map("o", "m", "<cmd>lua require('tsht').nodes()<cr>")
map("v", "m", "<cmd>lua require('tsht').nodes()<cr>")

-- LSP
local nullLs = require("null-ls")
nullLs.config({
	sources = {
		nullLs.builtins.formatting.stylua,
		nullLs.builtins.formatting.prettier.with({
			filetypes = {
				"svelte",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"yaml",
				"markdown",
				"graphql",
			},
			prefer_local = "node_modules/.bin",
		}),
		nullLs.builtins.formatting.rustywind, -- Tailwind class sorting
		nullLs.builtins.formatting.fish_indent,
		nullLs.builtins.formatting.taplo, -- TOML
	},
})

local on_attach = function(_, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

require("lspconfig")["null-ls"].setup({
	on_attach = on_attach,
})

-- :LspInstall tsserver tailwindcss svelte sumneko_lua
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local opts = { on_attach = on_attach, capabilities = capabilities }

	if server.name == "sumneko_lua" then
		opts.settings = {
			Lua = { diagnostics = { globals = { "vim" } } },
		}
	end

	server:setup(opts)
end)

-- Completions
vim.o.completeopt = "menuone,noselect"
local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}),
})
require("luasnip/loaders/from_vscode").lazy_load()

-- Treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	ignore_install = {}, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	textobjects = {
		enable = true,
		swap = {
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
	playground = {
		enable = true,
	},
})

-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr='nvim_treesitter#foldexpr()'

-- Autocommands
vim.cmd([[
  augroup auto_formatting
    autocmd!
    autocmd BufWritePre *.lua,*.svelte lua vim.lsp.buf.formatting_sync(nil, 100)
  augroup end
]])

vim.cmd([[
  augroup reload_nvim_config_and_run_packer_compile
    autocmd!
    autocmd BufWritePost $MYVIMRC source <afile> | PackerCompile
  augroup end
]])
