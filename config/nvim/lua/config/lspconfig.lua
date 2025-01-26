require("ddc_source_lsp_setup").setup()

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "typos_lsp",
        "tsserver",
        "gopls",
        "clangd",
        "pylsp",
        "sqls",
    }
})

local common_on_attach = function(client, bufnr)
    local set_buf_keymap = function(mode, lhs, rhs)
        local opts = {
            noremap = true,
            silent = true,
        }
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    set_buf_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>')
    set_buf_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    set_buf_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    set_buf_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    set_buf_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    set_buf_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    set_buf_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    set_buf_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    set_buf_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')

    if client.supports_method "textDocument/format" then
        vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.format()'
    end
    if client.supports_method "textDocument/documentHighlight" then
        vim.opt.updatetime = 1000
        vim.api.nvim_set_hl(0, "LspReferenceText", { ctermbg = 8 })
        vim.api.nvim_set_hl(0, "LspReferenceRead", { ctermbg = 8 })
        vim.api.nvim_set_hl(0, "LspReferenceWrite", { ctermbg = 8 })
        vim.api.nvim_set_hl(0, "DiagnosticSignError", { ctermfg = 15, ctermbg = 9 })
        vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { ctermfg = 0, ctermbg = 11 })
        vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { ctermfg = 15, ctermbg = 0 })
        vim.cmd 'autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()'
        vim.cmd 'autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()'
    end
end

local lspconfig = require('lspconfig')

local handlers = {
    -- default handler
    function(server_name)
        lspconfig[server_name].setup {
            on_attach = common_on_attach
        }
    end,
    -- override for specifics
    ["clangd"] = function()
        lspconfig.clangd.setup {
            init_options = {
                fallbackFlags = { '-std=c++17' },
            },
        }
    end,
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        }
    end,
    ["sqls"] = function()
        lspconfig.sqls.setup {
            on_attach = function(client, bufnr)
                require('sqls').on_attach(client, bufnr)
                common_on_attach(client, bufnr)
            end,
            settings = {
                sqls = {
                    connections = {
                        {
                            driver = 'postgresql',
                            dataSourceName = 'host=127.0.0.1 port=5432 user=postgres password=secret dbname=postgres sslmode=disable',
                        },
                    },
                },
            },
        }
    end,
}
require("mason-lspconfig").setup_handlers(handlers)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
    }
)
