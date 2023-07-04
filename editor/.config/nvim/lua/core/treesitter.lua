local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
    ensure_installed = { "help", "bash", "c", "json", "lua", "python", "typescript", "tsx", "rust", "yaml", "markdown", "markdown_inline" },
	ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
    auto_install = true,
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },
})
