-- Copied from https://dev.to/slydragonn/how-to-set-up-neovim-for-windows-and-linux-with-lua-and-packer-2391
local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
    return
end

autopairs.setup({
    disable_filetype = { "TelescopePrompt", "vim" },
})
