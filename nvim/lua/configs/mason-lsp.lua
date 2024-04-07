-- Taken from https://dev.to/slydragonn/how-to-set-up-neovim-for-windows-and-linux-with-lua-and-packer-2391
local status, masonlsp = pcall(require, "mason-lspconfig")

if not status then
    return
end

masonlsp.setup({
    automatic_installation = true,
    ensure_installed = {
        "cssls",
        "eslint",
        "html",
        "jsonls",
        "tsserver",
        "pyright",
        "tailwindcss",
    },
})
