-- 考虑到本地迁移的情况, 且 tex 非必要安装, 仅设置默认推荐
if true or vim.fn.executable("latexmk") == 0 then return {} end

return {
  -- WARNING: 需要 tex 依赖
  { import = "pithyvim.plugins.extras.lang.tex" },
}
