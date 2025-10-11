
# 基于 blink.cmp 默认搜索位置导入 (recommand)

1. 如果不存在，请创建 `~/.config/nvim/snippets/` 用于保存代码片段的目录

   这是代码blink.cmp片段的默认查找位置

1. 如果文件不存在，则创建 `~/.config/nvim/snippets/package.json`

   它需要包含所有代码片段文件的列表。在本例中，我们将添加 `markdown`：

   ```json
   {
     "name": "pithyvimart-snippets",
     "contributes": {
       "snippets": [
         { "language": "markdown", "path": "./snippets/markdown/markdown.json" }
       ]
     }
   }
   ```

   > `markdown.json` 格式见 [vim-snippets](https://github.com/rafamadriz/friendly-snippets/tree/main/snippets)


# 基于 luasnip 导入

## from_vscode

通过 `require("luasnip.loaders.from_vscode").lazy_load([路径])` 导入

json 格式见 [vim-snippets](https://github.com/rafamadriz/friendly-snippets/tree/main/snippets)

## from_snipmate

通过 `require("luasnip.loaders.from_snipmate").lazy_load([路径])` 导入

snipmate 格式见 [snipmate](https://github.com/honza/vim-snippets/blob/master/snippets/)

## 示例

```lua
-- add luasnip
{
  "L3MON4D3/LuaSnip",
  lazy = true,
  build = (not PithyVim.is_win())
      and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
    or nil,
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        --{{{> Qeuroal
        -- Note: 如果要使用自定义片段, 必须打开 luasnip 插件
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets/from_vscode" } })
        require("luasnip.loaders.from_snipmate").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets/from_snipmate" } })
        --<}}}
      end,
    },
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
},
```

