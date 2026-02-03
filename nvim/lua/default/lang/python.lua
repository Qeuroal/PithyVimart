if (vim.fn.executable("python") == 0 and vim.fn.executable("python3") == 0) then return {} end

return {
  { import = "pithyvim.plugins.extras.lang.python" },
}
