if vim.env.VSCODE then
  vim.g.vscode = true
end

if vim.loader then
  vim.loader.enable()
end

pcall(require, "config.env")

-- bootstrap lazy.nvim, PithyVim and your plugins
require("config.lazy")


