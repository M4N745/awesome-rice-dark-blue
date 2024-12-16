-- Ensure packer is installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer .nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Load plugins
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim' -- Packer can manage itself
	use 'tiagovla/tokyodark.nvim' -- theme
	use 'nvim-tree/nvim-web-devicons' -- files icons
	use 'nvim-tree/nvim-tree.lua' -- files tree (folder)
	use 'neovim/nvim-lspconfig' -- lspconfig (required for autocompletion
	use {
		'ms-jpg/coq_nvim',
		branch = 'coq',
		run = 'python3 -m coq deps',
		url = 'git@github.com:ms-jpg/coq_nvim.git'
	}


	requires = {
		'nvim-tree/nvim-web-devicons'
	}

	if packer_bootstrap then
		require('packer').sync()
	end
end)


local default_config = {
    transparent_background = true, -- set background to transparent
    gamma = 1.00, -- adjust the brightness of the theme
    styles = {
        comments = { italic = true }, -- style for comments
        keywords = { italic = true }, -- style for keywords
        identifiers = { italic = true }, -- style for identifiers
        functions = {}, -- style for functions
        variables = {}, -- style for variables
    },
    custom_highlights = {} or function(highlights, palette) return {} end, -- extend highlights
    custom_palette = {} or function(palette) return {} end, -- extend palette
    terminal_colors = true, -- enable terminal colors
}

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
-- lspconfig
vim.g.coq_settings = {
	auto_start = 'shut-up',
	display = {
		icons = {
			mode = 'short'
		}
	}
}

local coq = require('coq')
local lspconfig = require("lspconfig")

lspconfig.ts_ls.setup(coq.lsp_ensure_capabilities({
	on_attach = function(client, bufnr)
		local opts = { noremap = true, silent = true }
		local keymap = vim.api.nvim_buf_set_keymap

		keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	end,
}))


-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 40,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Check if no files are opened
    if #vim.fn.argv() == 0 then
      require("nvim-tree.api").tree.open()
    end
  end,
})

vim.o.number = true
vim.cmd[[colorscheme tokyodark]]
