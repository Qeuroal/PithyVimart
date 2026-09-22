# 支持

- Linux
- MacOS
- Windows

# 下载

## 安装 neovim

下载页面为 [Releases](https://github.com/neovim/neovim/releases).

- Latest [stable release](https://github.com/neovim/neovim/releases/latest)

   - [macOS x86](https://github.com/neovim/neovim/releases/latest/download/nvim-macos-x86_64.tar.gz)
   - [macOS arm](https://github.com/neovim/neovim/releases/latest/download/nvim-macos-arm64.tar.gz)
   - [Linux](https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz)
   - [Windows](https://github.com/neovim/neovim/releases/latest/download/nvim-win64.msi)

- Latest [development prerelease](https://github.com/neovim/neovim/releases/nightly)

## 下载 pithyvimart

1. 克隆仓库: `git clone https://github.com/Qeuroal/PithyVimart.git`

   - 完整克隆 `git clone https://github.com/Qeuroal/PithyVimart.git --recursive`

      > 如果只需要安装, 而不需要安装字体, 则无须 **完整克隆**

   - 克隆 dev 分支 (下面两个命令等价)

      - `git clone https://github.com/Qeuroal/PithyVimart.git --recursive --branch dev`
      - `git clone https://github.com/Qeuroal/PithyVimart.git --recursive -b dev`

1. 按需运行命令

   - 安装 PithyVimart: `make`
   - 安装依赖: `make build`

      默认更新 submodule, 即先运行下面的命令

      ```bash
      git submodule init
      git submodule update
      ```

   - 彻底删除 PithyVimart: `make cleanall` 或 `make ca`

# 安装

**配置入口文件:**

- Unix: `~/.config/nvim/init.vim` (or `init.lua`)
- Windows: `~/AppData/Local/nvim/init.vim` (or `init.lua`)
- [\$XDG_CONFIG_HOME](https://neovim.io/doc/user/starting.html#%24XDG_CONFIG_HOME): `$XDG_CONFIG_HOME/nvim/init.vim` (or `init.lua`)

## Linux/MacOS

### 依赖项

- 必选项

   - [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-download)

      步骤:

      1. 下载 Latest stable release ([macos x64](https://github.com/neovim/neovim/releases/latest/download/nvim-macos-x86_64.tar.gz), [macos arm](https://github.com/neovim/neovim/releases/latest/download/nvim-macos-arm64.tar.gz), [linux](https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz))
      1. 解压, 并修改文件名为nvim

         ```bash
         tar -zxvf ./<目标文件> [-C <目标目录>]
         mv <解压出的文件夹名> nvim
         ```

      1. 移动解压的目录到 `/usr/local/`

         ```bash
         sudo mv ./nvim /usr/local
         ```

      1. 链接可执行文件 nvim 到 `/usr/bin/`

         ```bash
         sudo ln -sf /usr/local/bin/nvim /usr/bin/nvim
         ```

      1. 重启终端

- 可选项

   - eza

      - Linux下载地址: [https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.zip](https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.zip)
      - MacOS 下载: `brew install eza`

> [!TIP]
> **proxy**
> Linux/MacOS: `export HTTP_PROXY=http://${PROXY_IP:-127.0.0.1}:${PROXY_PORT:-7890} HTTPS_PROXY=http://${PROXY_IP:-127.0.0.1}:${PROXY_PORT:-7890} FTP_PROXY=http://${PROXY_IP:-127.0.0.1}:${PROXY_PORT:-7890} ALL_PROXY=socks://${PROXY_IP:-127.0.0.1}:${PROXY_PORT:-7890} NO_PROXY=localhost,127.0.0.0/8,::1 http_proxy=http://${PROXY_IP:-127.0.0.1}:${PROXY_PORT:-7890} https_proxy=http://${PROXY_IP:-127.0.0.1}:${PROXY_PORT:-7890} ftp_proxy=http://${PROXY_IP:-127.0.0.1}:${PROXY_PORT:-7890} all_proxy=socks://${PROXY_IP:-127.0.0.1}:${PROXY_PORT:-7890} no_proxy=localhost,127.0.0.0/8,::1`

## Windows

### 依赖项

- 必选项

   - neovim ([官网](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-download), [win64](https://github.com/neovim/neovim/releases/latest/download/nvim-win64.msi))
   - git
   - mingw ([官网](https://www.mingw-w64.org/downloads/), [github](https://github.com/niXman/mingw-builds-binaries))
   - npm (node.js) ([官网](https://nodejs.cn/download/))
   - rg (ripgrep) ([官网](https://github.com/BurntSushi/ripgrep/releases/))

### 安装步骤

Install the [PithyVimart](https://github.com/qeuroal/Pithyvimart) with [PowerShell](https://github.com/PowerShell/PowerShell)

- Make a backup of your current Neovim files:

   ```powershell
   # required
   Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak

   # optional but recommended, which makes a backup
   Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak
   ```

- Clone the starter

   ```powershell
   git clone https://github.com/qeuroal/pithyvimart.git $env:LOCALAPPDATA\nvim
   ```

- **(optional but not recommended)** Remove the `.git` folder, so you can add it to your own repo later

   ```powershell
   Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force
   ```

- Start Neovim!

   ```powershell
   nvim
   ```

> [!TIP]
> **proxy**
> - POWERSHELL: `$Env:http_proxy="http://127.0.0.1:7890";$Env:https_proxy="http://127.0.0.1:7890";$Env:socket_proxy="http://127.0.0.1:7890";$Env:all_proxy="http://127.0.0.1:7890"`
> - CMD: `set "http_proxy=http://127.0.0.1:7890" & set "https_proxy=http://127.0.0.1:7890" & set "all_proxy=http://127.0.0.1:7890" & set "socket_proxy=http://127.0.0.1:7890"`


# 插件

## 依赖项

> [!TIP]
> 方便起见, 可以先不安装这些插件的依赖项, 如果有报错再根据错误信息安装相应的依赖项即可 (`<leader>n` 可以用来查看通知历史, 包括错误信息).

### global

#### npm

- archlinux: `sudo pacman -S --noconfirm npm`
- ubuntu: `sudo apt-get -y install npm`
- fedora: `sudo dnf install -y npm`
- macos: `brew install node`

### markdown

#### markdownlint-cli2

- archlinux: `sudo pacman -S --noconfirm markdownlint-cli2`
- macos:
   - `brew install markdownlint-cli2`
   - `npm install -g markdownlint-cli2`
- ubuntu: `sudo apt install markdownlint`

# 定制配置

## 项目自定义配置

### 使用 .lazy.lua 文件

通过本地配置功能，可以在项目根目录的 `.lazy.lua` 文件中编写项目配置。当你在 Neovim 中打开项目并允许加载该文件后，这些设置就会生效。

**项目特定配置**

在项目根目录中创建一个文件, 以下是一个示例 `.lazy.lua`:

```lua
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.g.autoformat = false

return {}
```

与 `~/.config/nvim/lua/plugins/` 中的插件配置一样，文件末尾必须返回一个表，即使是空表 `return {}`。

然后, 如果您关闭 NeoVim 并在项目目录中重新打开它, 您会看到一个提示, 询问您是否信任该 `.lazy.lua` 文件:

```text
~/my-project/.lazy.lua is not trusted.
   [i]gnore, (v)iew, (d)eny, (a)llow:
```

这是因为 `.lazy.lua` 是一个可以执行任意代码的 Lua 脚本。确认信任该文件后，可以按下 `a` 允许加载。
在上面的示例中，我们将 `tabstop` 和 `shiftwidth` 设置为 4，并禁用自动格式化。你可以根据需要添加更多设置。

**项目特定的插件配置**

还可以为插件设置不同的配置, 这些配置将合并到 `~/.config/nvim` 目录中的全局配置中, 以下是一个示例：

```lua
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        java = { "google-java-format" },
        vue = { " EsLintFixAll" },
      },
    },
  },
}
```

在配置中, 我们复制插件定义 `stevearc/conform.nvim` 并对 Java 和 Vue 文件类型设置不同的 `formatters_by_ft`, 将设置 `google-java-format` 为 Java 文件格式化程序, 将设置 `EsLintFixAll` 为 Vue 文件  `linter` , 这些设置将递归复制到全局插件配置中, 因此您不必担心会丢失某些全局配置.

**文件类型特定配置**

甚至可以在 `.lazy.lua` 文件中为项目特定的配置添加文件类型特定的配置, 以下是一个示例：

```lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  group = vim.api.nvim_create_augroup("json", { clear = true }),
  callback = function(opts)
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.g.autoformat = true
  end,
})

return {}
```

在这个例子中，我们为 JSON 文件类型创建了一个自动命令，将 `tabstop` 和 `shiftwidth` 设置为 2，并启用自动格式化，适用于使用 2 个空格缩进的 JSON 文件。

> 参考[这里](https://kezhenxu94.me/blog/lazyvim-project-specific-settings)

**设置项目级 snacks**

```lua
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            follow = true, -- follow symlinks
            hidden = true, -- show hidden files
          },
          grep = {
            follow = true, -- follow symlinks
            hidden = true,
          },
          grep_word = {
            follow = true, -- follow symlinks
          },
          explorer = {
            hidden = true,
            -- ignored = true, -- show ignored files
            layout = {
              preset = "sidebar",
              preview = { main = true, enabled = false },
            },
          },
        },
      },
    },
  },
}
```

#### QAs

[重新信任 `.lazy.lua`](docs/QAs.md#重新信任-lazylua)

## 定制 SHELL config

默认导入路径为: `$HOME/.config/pithy_custom_config` 文件, **如果存在, 则默认导入**.

> [!TIP]
> 该文件为 **唯一** 的导入外部配置的文件.

## 使用 EditorConfig

在项目中创建 `.editorconfig` 文件.

- 总控文件: `$HOME/.editorconfig`

### help

- 查看当前文件读取到的全部 EditorConfig 属性

   ```vim
   :lua print(vim.inspect(vim.b.editorconfig))
   ```

- 查看向上所有可能找到的文件：

   ```vim
   :lua local p=vim.fs.dirname(vim.api.nvim_buf_get_name(0)); vim.print(vim.fs.find(".editorconfig", { path=p, upward=true, limit=math.huge }))
   ```

### refs

- [EditorConfig 官方网站](https://editorconfig.org/)

# 资料相关

- Nerd Fonts 字体: 字体下载与安装方法见 [Nerd Fonts 字体](docs/font.md)

# QAs

常见问题与解决方法见 [QAs](docs/QAs.md)。
