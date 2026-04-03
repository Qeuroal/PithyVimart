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
> proxy
>
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
- macos: `brew install markdownlint-cli2`
- ubuntu: `sudo apt install markdownlint`

# 定制配置

## 项目自定义配置

### 使用 .lazy.lua 文件

有一个不太为人所知的功能叫做本地配置, 它允许 `.lazy.lua` 在项目根目录下的一个文件中编写项目特定的配置, 当你在 NeoVim 中打开项目时, 这些设置就会被加载.

**项目特定配置**

在项目根目录中创建一个文件, 以下是一个示例 `.lazy.lua`:

```lua
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.g.autoformat = false

return {}
```

`~/.config/nvim/lua/plugins/` 就像你在目录中编写插件配置时, 即使表格为空, 也 ***必须*** 在文件末尾添加一个 `return` 语句一样 `{}`.

然后, 如果您关闭 NeoVim 并在项目目录中重新打开它, 您会看到一个提示, 询问您是否信任该 `.lazy.lua` 文件:

```lua
~/my-project/.lazy.lua is not trusted.
   [i]gnore, (v)iew, (d)eny, (a)llow:
```

这是因为它是一个 Lua 脚本, 可以执行任意代码, 您可以按下a允许键, 然后设置 `.lazy.lua` 将被加载.
在上面的示例代码中, 我们将 `tabstop` 和设置 `shiftwidth` 为 4, 并禁用自动格式化, 您可以根据需要向此文件添加更多设置.

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

在这个例子中, 我们创建了一个 `autocmd` 文件 Json 类型, 并将 `tabstop` 和设置 `shiftwidth` 为 2, 并启用 Json 文件的自动格式化.当您处理使用紧凑缩进样式（在本例中为 2 个空格）的 Json 文件项目时, 这将非常有用.

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

**重新信任 `.lazy.lua`** 

1. 打开文件 `~/.local/state/nvim/trust`
1. 删除目标项目 `.lazy.lua` 的那行
1. 重新打开项目, 允许即可

> [!TIP]
> trust 文件格式
>
> - 拒绝为: `! <项目目录>/.lazy.lua`
> - 允许为: `<xxx> <项目目录>/.lazy.lua`

## 定制 SHELL config

默认导入路径为: `$HOME/.config/pithy_custom_config` 文件, **如果存在, 则默认导入**.

> [!TIP]
> 该文件为 **唯一** 的导入外部配置的文件.

# 资料相关

## Nerd Fonts 字体

### 下载

- [Nerd Fonts 下载网址](https://www.nerdfonts.com/font-downloads): 包含所有常用的 Nerd Fonts 字体
- JetBrainsMono Nerd Font [点击下载](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip)

### 手动安装

- MacOS

   1. 将字体所在文件夹移动到 `~/Library/Fonts` 目录
   1. 运行命令: `fc-cache -vf`
   1. 查看字体列表: `fc-list`

- Linux:

   1. 将字体所在文件夹移动到 `~/.local/share/fonts` 目录
   1. 运行命令: `fc-cache -vf`
   1. 查看字体列表: `fc-list`

- Windows:

   1. 选中字体文件, 右键-安装

# QAs

- neovim default setting

[见 https://neovim.io/doc/user/vim_diff.html#nvim-defaults](https://neovim.io/doc/user/vim_diff.html#nvim-defaults)

- 如何查看配置路径

   ```vim
   :echo stdpath('config')
   ```

- create your [init.vim](https://neovim.io/doc/user/starting.html#init.vim) (user config) file:

   ```vim
   :exe 'edit '.stdpath('config').'/init.vim'
   :write ++p
   ```

## Common

- Error running markdownlint-cli2: ENOENT: no such file or directory

   安装 markdownlint 依赖项, 具体[见这里](#markdownlint-cli2)


- 插件存在异常情况: 使用 `checkhealth <插件名>` 查看是否存在 error.

## Linux

- 添加 AppImage ("universal" Linux package)

   The [Releases](https://github.com/neovim/neovim/releases) page provides an [AppImage](https://appimage.org) that runs on most Linux systems. No installation is needed, just download `nvim.appimage` and run it. (It might not work if your Linux distribution is more than 4 years old.)

   ```bash
   curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
   chmod u+x nvim.appimage
   ./nvim.appimage
   ```

   To expose nvim globally:

   ```bash
   mkdir -p /opt/nvim
   mv nvim.appimage /opt/nvim/nvim
   ```

   And the following line to your shell config (`~/.bashrc`, `~/.zshrc`, ...):

   export PATH="$PATH:/opt/nvim/"

   If the `./nvim.appimage` command fails, try:

   ```bash
   ./nvim.appimage --appimage-extract
   ./squashfs-root/AppRun --version

   # Optional: exposing nvim globally.
   sudo mv squashfs-root /
   sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
   nvim
   ```

- Python module

   - archlinux

      The Python module is available from the community repository:

      ```bash
      sudo pacman -S python-pynvim
      ```

   - ubuntu

      Python (`:python`) support is installable via the package manager on Debian unstable.

      ```bash
      sudo apt-get install python3-neovim
      ```

   - fedora

      Neovim is in [Fedora](https://src.fedoraproject.org/rpms/neovim) starting with Fedora 25:

      ```bash
      sudo dnf install -y neovim python3-neovim
      ```

      You can also get nightly builds of git master from the [Copr automated build system](https://copr.fedoraproject.org/coprs/agriffis/neovim-nightly/):

      ```bash
      dnf copr enable agriffis/neovim-nightly
      dnf install -y neovim python3-neovim
      ```

      See the [blog post](https://arongriffis.com/2019-03-02-neovim-nightly-builds) for information on how these are built.

- Ruby modules

   - archlinux

      (currently only supported in `neovim-git`) are available from the AUR as [`ruby-neovim`](https://aur.archlinux.org/packages/ruby-neovim).

- `/nvim/lazy/mason.nvim/lua/mason-core/installer/init.lua:249: Installation failed for Package(name=ruff ↪) error=spawn: python3 failed with exit code 1 and signal 0`

   ruff often relies on Python virtual environments for installation. If you are on an Ubuntu or Debian-based system, the python3-venv package might be missing. Install it using:

   ```bash
   sudo apt install python3-venv
   ```

- nvim 版本太低

   - archlinux: `yay -S neovim-git`
   - ubuntu
      ```bash
      sudo add-apt-repository ppa:neovim-ppa/stable
      sudo apt update
      sudo apt install neovim
      ```

## MacOS

- Mac 系统没有 Alt 键，Option 键也不管用，如何设置 Command 快捷键

   在我们的配置中，Mac 系统的 Option 键对应的是 Windows 系统的 Alt 键，如果你的 Option 键没有反应，通常需要设置一下你的终端，将 Option 键设置为 Meta 键。
   - Item2: 设置方式为 Preference -> Profiles -> Default --> Keys --> Left Option key --> 选中 Esc+
   - alacritty: 设置 `[window]` 的 `option_as_alt` 为 `OnlyLeft`, 如下所示:
      ```toml
      [window]
      option_as_alt = "OnlyLeft"
      ```

## Windows

- 缺失 `VCRUNTIME140.dll`

   1. If you are missing `VCRUNTIME140.dll`, install the [Visual Studio 2015 C++ redistributable](https://support.microsoft.com/en-us/kb/2977003) (choose x86_64 or x86 depending on your system).
   1. Choose a package (**nvim-winXX.zip**) from the [releases page](https://github.com/neovim/neovim/releases).
   1. Unzip the package. Any location is fine, administrator privileges are _not_ required.
   1. `$VIMRUNTIME` will be set to that location automatically.
   1. Run `nvim.exe` from a terminal.

- Windows 系统无法使用 `nvim` 编辑文件

   添加PATH: 添加 nvim 程序的 `bin` 文件夹 (e.g. `C:\Program Files\nvim\bin`) 到系统 PATH.

- 拼写检查无效

   If `:set spell` does not work, create the `C:/Users/foo/AppData/Local/nvim/site/spell` folder.

   You can then copy your spell files over (for English, located [here](https://github.com/vim/vim/blob/master/runtime/spell/en.utf-8.spl) and [here](https://github.com/vim/vim/blob/master/runtime/spell/en.utf-8.sug));

- For Python plugins you need the `pynvim` module. "Virtual envs" are recommended.

   1. After activating the virtual env do `pip install pynvim` (in _both_). Edit your `init.vim` so that it contains the path to the env's Python executable:

      ```vim
      let g:python3_host_prog='C:/Users/foo/Envs/neovim3/Scripts/python.exe'
      ```

   2. Run `:checkhealth` and read `:help provider-python`.

- windows 的 ubuntu 子系统下安装插件报错 could not find executable "unzip" in path?

   因为缺少压缩解压软件, 需要安装 zip unzip.

   ```bash
   sudo apt-get install zip unzip
   ```

## trick

- 直接编辑服务器文件: `nvim scp:://user@hostname//path/to/file`

## 验证 proxy

通过 curl 查看它到底「听不听话」

使用 curl 的详细模式 (-v): `curl -v http://www.google.com`

观察输出中的前几行：

- 成功标志: 如果你看到类似下面的字样，说明环境变量生效了

   ```bash
   * Uses proxy env variable http_proxy == 'http://127.0.0.1:7890' * Trying 127.0.0.1:7890... * Connected to 127.0.0.1 (127.0.0.1) port 7890
   ```

- 失败标志: 如果你看到它直接去连接 Google 的 IP，说明代理没被识别，或者被忽略了

   ```bash
   * Trying 142.250.x.x...
   ```

> 补充知识
>
> - `http_proxy / https_proxy`: 绝大多数命令行工具（`curl`, `git`, `npm`）都认这两个.
> - `all_proxy`: 通常被 `curl` 和 `wget` 作为备选方案使用.
> - `socket_proxy`: 这个变量不是标准的 Windows 或 Linux 环境变量. 虽然您设置成功了, 但绝大多数软件 (如 Chrome, Git, Curl) 不会自动读取它. 除非使用的特定软件明确说明需要读取名为 `socket_proxy` 的变量，否则它可能只是个摆设。

## 参考

- [neovim安装官方教程](https://github.com/neovim/neovim/blob/master/INSTALL.md)
- [neovim初始化官方教程](https://neovim.io/doc/user/starting.html#_initialization)
- [nvim.html](https://neovim.io/doc/user/nvim.html)

