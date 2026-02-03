if vim.fn.executable("latexmk") == 0 then return {} end

return {
  -- WARNING: 需要 tex 依赖
  { import = "pithyvim.plugins.extras.lang.tex" },
}
