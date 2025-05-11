return {
  -- fix, by simply pinning the versions
  -- bug: Failed to run config for nvim-lspconfig after mason upgrade
  -- { "mason-org/mason.nvim", version = "^1.11.0" },
  -- { "mason-org/mason-lspconfig.nvim", version = "^1.32.0" },
  { "Qeuroal/PithyVim", import = "pithyvim.plugins", branch = "fix_mason" },
}
