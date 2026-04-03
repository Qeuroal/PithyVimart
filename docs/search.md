# Files and Grep

双引擎搜索 ripgrep(rg) + fzf

1. 粗筛(利用 rg 正则 + 参数)

   支持添加选项, 如: `foo -- -t lua`, 实际上, Snacks.picker 在后台帮你拼接出了这样一条终端命令去执行: `rg foo -t lua`.

1. 精筛(按 `<C-g>` 切换到 fzf 语法)

    按 `<C-g>` 关闭 Live 模式，使用[fzf 搜索语法](#fzf-搜索语法)过滤.

    此外, 支持"字段搜索/字段过滤", 如 `file:lua$ 'function`.

> 总结经验法则：
>
> - 想要控制**大小写**、**指定文件类型**, 一定要在 **Live 模式** 下用 `-- -s`、`-- -t` 等 `ripgrep` 参数解决.
> - 想要执行**逻辑排除 (NOT)** 或**多条件组合 (AND)**, 才按下 **`<C-g>`** 用 fzf 的 `!x` 或空格来解决.

## ripgrep 正则表达式

见[这里](https://docs.rs/regex/1.12.3/regex/#syntax).

## fzf 搜索语法

Unless otherwise specified, fzf starts in "extended-search mode" where you can type in multiple search terms delimited by spaces. e.g. `^music .mp3$ sbtrkt !fire`

| Token     | Match type                              | Description                                  |
| --------- | --------------------------------------- | -------------------------------------------- |
| `sbtrkt`  | fuzzy-match                             | Items that match `sbtrkt`                    |
| `'wild`   | exact-match (quoted)                    | Items that include `wild`                    |
| `'wild'`  | exact-boundary-match (quoted both ends) | Items that include `wild` at word boundaries |
| `^music`  | prefix-exact-match                      | Items that start with `music`                |
| `.mp3$`   | suffix-exact-match                      | Items that end with `.mp3`                   |
| `!fire`   | inverse-exact-match                     | Items that do not include `fire`             |
| `!^music` | inverse-prefix-exact-match              | Items that do not start with `music`         |
| `!.mp3$`  | inverse-suffix-exact-match              | Items that do not end with `.mp3`            |

If you don't prefer fuzzy matching and do not wish to "quote" every word, start fzf with `-e` or `--exact` option. Note that when `--exact` is set, `'`-prefix "unquotes" the term.

A single bar character term acts as an OR operator. For example, the following query matches entries that start with `core` and end with either `go`, `rb`, or `py`.

```
^core go$ | rb$ | py$
```
