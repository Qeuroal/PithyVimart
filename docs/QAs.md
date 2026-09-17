# Common

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

- Error running markdownlint-cli2: ENOENT: no such file or directory

   安装 markdownlint 依赖项, 具体[见这里](../README.md#markdownlint-cli2)


- 插件存在异常情况: 使用 `checkhealth <插件名>` 查看是否存在 error.

## 重新信任 `.lazy.lua`

1. 打开文件 `~/.local/state/nvim/trust`
1. 删除目标项目 `.lazy.lua` 的那行
1. 重新打开项目, 允许即可

> [!TIP]
> **trust 文件格式**
> - 拒绝为: `! <项目目录>/.lazy.lua`
> - 允许为: `<xxx> <项目目录>/.lazy.lua`

# Linux

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

   ```bash
   export PATH="$PATH:/opt/nvim/"
   ```

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

# MacOS

- Mac 系统没有 Alt 键，Option 键也不管用，如何设置 Command 快捷键

   在我们的配置中，Mac 系统的 Option 键对应的是 Windows 系统的 Alt 键，如果你的 Option 键没有反应，通常需要设置一下你的终端，将 Option 键设置为 Meta 键。
   - Item2: 设置方式为 Preference -> Profiles -> Default --> Keys --> Left Option key --> 选中 Esc+
   - alacritty: 设置 `[window]` 的 `option_as_alt` 为 `OnlyLeft`, 如下所示:
      ```toml
      [window]
      option_as_alt = "OnlyLeft"
      ```

# windows

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

## Ghostscript 已安装，但 Snacks 找不到 `gs`

Ghostscript 的 64 位 Windows 命令行程序名是 `gswin64c.exe`，安装后可能位于：

```text
C:\Program Files\gs\gs10.07.1\bin\gswin64c.exe
```

先检查：

```bat
where.exe gswin64c
```

如果输出类似下面的路径：

```text
C:\Program Files\gs\gs10.07.1\bin\gswin64c.exe
```

但执行以下命令时找不到文件：

```bat
where.exe gs
```

说明 Ghostscript 已经安装，但 Snacks 找不到 `gs` 这个命令名。可以创建一个包装命令，例如新建：

```text
C:\Users\你的用户名\bin\gs.cmd
```

写入以下内容，路径替换为实际安装路径：

```bat
@echo off
"C:\Program Files\gs\gs10.07.1\bin\gswin64c.exe" %*
```

将 `C:\Users\你的用户名\bin` 加入用户的 `PATH` 环境变量，然后重新打开终端并重启 Neovim。再次执行 `where.exe gs`，确认能找到 `gs.cmd`。

# trick

- 直接编辑服务器文件: `nvim scp:://user@hostname//path/to/file`

# 验证 proxy

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

> **补充知识**
> - `http_proxy / https_proxy`: 绝大多数命令行工具（`curl`, `git`, `npm`）都认这两个.
> - `all_proxy`: 通常被 `curl` 和 `wget` 作为备选方案使用.
> - `socket_proxy`: 这个变量不是标准的 Windows 或 Linux 环境变量. 虽然您设置成功了, 但绝大多数软件 (如 Chrome, Git, Curl) 不会自动读取它. 除非使用的特定软件明确说明需要读取名为 `socket_proxy` 的变量，否则它可能只是个摆设。

# 参考

- [neovim安装官方教程](https://github.com/neovim/neovim/blob/master/INSTALL.md)
- [neovim初始化官方教程](https://neovim.io/doc/user/starting.html#_initialization)
- [nvim.html](https://neovim.io/doc/user/nvim.html)
