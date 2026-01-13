local servers = {
    "clangd",
    "pylsp",
    "rust_analyzer",
    "lua_ls",
}

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
})
local handlers = require("core.lsp.handlers")

-- Configure each server using native vim.lsp.config()
for _, server in ipairs(servers) do
    local config = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
    }
    -- Load server-specific settings if they exist
    local require_ok, server_opts = pcall(require, "core.lsp.servers." .. server)
    if require_ok then
        config = vim.tbl_deep_extend("force", config, server_opts)
    end

    vim.lsp.config(server, config)
end
-- Enable all configured servers
vim.lsp.enable(servers)
