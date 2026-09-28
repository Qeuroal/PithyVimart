# 命令行在已经打开的 Neovim 中打开文件

1. 在目标 Neovim 中查看 socket 地址: `:echo v:servername`
1. 在终端中打开文件:

   ```bash
   nvim --server 'socket地址' --remote '/文件的绝对路径'
   ```

   将 socket地址 替换为第一步输出的完整地址, 文件会在原来的 Neovim 中打开.

## refs

- [Neovim 远程控制：--server、--remote、--remote-expr](https://neovim.io/doc/user/remote/)
- [Neovim 变量：v:servername](https://neovim.io/doc/user/vvars/#v%3Aservername)
- [启动过程](https://neovim.io/doc/user/starting/#initialization)

