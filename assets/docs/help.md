
# 正则表达试

## 贪婪与非贪婪匹配

| 符号 | 含义 |
| - | - |
| `\{n,m}` | Matches n to m of the preceding atom, as many as possible |
| `\{n}` | Matches n of the preceding atom |
| `\{n,}` | Matches at least n of the preceding atom, as many as possible |
| `\{,m}` | Matches 0 to m of the preceding atom, as many as possible |
| `\{}` | Matches 0 or more of the preceding atom, as many as possible (like "*") |
| `\{-n,m}` | matches n to m of the preceding atom, as few as possible |
| `\{-n}` | matches n of the preceding atom |
| `\{-n,}` | matches at least n of the preceding atom, as few as possible |
| `\{-,m}` | matches 0 to m of the preceding atom, as few as possible |
| `\{-}` | matches 0 or more of the preceding atom, as few as possible |

> see more `:help /multi` and `:help pattern-multi-items`
