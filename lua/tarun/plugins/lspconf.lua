local lspconfig = require('lspconfig')

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'html', 'lua_ls', 'cssls', 'eslint', 'pyright', 'tsserver' },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.lua_ls.setup({
    capabilties = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
        workspace = {
            library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.stdpath('config') .. '/lua'] = true,
            },
        },
    },
})

local lang_servers = {
    'cssls',
    'eslint',
    'pyright',
    'tsserver',
    'emmet_language_server',
    'html',
}

for _, server in ipairs(lang_servers) do
    lspconfig[server].setup({
        capabilities = capabilities,
    })
end

local signs = { Error = '󰅚 ', Warn = '󰀪 ', Hint = '󰌶 ', Info = ' ' }

vim.diagnostic.config({
    -- virtual_text = {
    -- 	prefix = ' ',
    -- },
    virtual_text = false,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
    float = { focusable = false, style = 'minimal', border = 'rounded', source = 'always', header = '', prefix = '' },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.INFO] = signs.Info,
            [vim.diagnostic.severity.HINT] = signs.Hint,
        },
    },
})

require('trouble').setup({
    auto_close = true,
    use_diagnostic_signs = true,
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
    title = 'Signature Help',
    focusable = true,
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
    focusable = true,
    title = 'Hover',
})

require('lsp_lines').setup()
