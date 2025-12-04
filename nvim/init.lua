require("config.lazy")
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- set up lazyvim
vim.env.PATH = vim.env.HOME .. "/python/.venv/bin:" .. vim.env.PATH

-- add jk to escape
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

-- tab for python
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = false
  end,
})
