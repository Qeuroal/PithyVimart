# 支持

* Linux
* MacOS
* Windows

# 下载

## 安装 neovim

下载页面为 [Releases](https://github.com/neovim/neovim/releases).

* Latest [stable release](https://github.com/neovim/neovim/releases/latest)
  * [macOS x86](https://github.com/neovim/neovim/releases/latest/download/nvim-macos-x86_64.tar.gz)
  * [macOS arm](https://github.com/neovim/neovim/releases/latest/download/nvim-macos-arm64.tar.gz)
  * [Linux](https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz)
  * [Windows](https://github.com/neovim/neovim/releases/latest/download/nvim-win64.msi)
* Latest [development prerelease](https://github.com/neovim/neovim/releases/nightly)

## 下载 pithyvimart

1. 克隆仓库: `git clone https://github.com/Qeuroal/PithyVimart.git`

  * 完整克隆 `git clone https://github.com/Qeuroal/PithyVimart.git --recursive`

    > 如果只需要安装, 而不需要安装字体, 则无须 **完整克隆**

  * 克隆 dev 分支 (下面两个命令等价)

    * `git clone https://github.com/Qeuroal/PithyVimart.git --recursive --branch dev`
    * `git clone https://github.com/Qeuroal/PithyVimart.git --recursive -b dev`


1. 按需运行命令

  * 安装 PithyVimart: `make`
  * 安装依赖: `make build`

    默认更新 submodule, 即先运行下面的命令

    ```bash
    git submodule init
    git submodule update
    ```

  * 彻底删除 PithyVimart: `make cleanall` 或 `make ca`

# 安装

**配置入口文件:**

* Unix: `~/.config/nvim/init.vim` (or `init.lua`)
* Windows: `~/AppData/Local/nvim/init.vim` (or `init.lua`)
* [\$XDG_CONFIG_HOME](https://neovim.io/doc/user/starting.html#%24XDG_CONFIG_HOME): `$XDG_CONFIG_HOME/nvim/init.vim` (or `init.lua`)

## Linux/MacOS

### 依赖项

* 必选项

  * [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-download)

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

  > [!TIP]
  > proxy
  > linux/macos: `export HTTP_PROXY=http://127.0.0.1:7890 HTTPS_PROXY=http://127.0.0.1:7890 FTP_PROXY=http://127.0.0.1:7890 ALL_PROXY=socks://127.0.0.1:7890 NO_PROXY=localhost,127.0.0.0/8,::1 http_proxy=http://127.0.0.1:7890 https_proxy=http://127.0.0.1:7890 ftp_proxy=http://127.0.0.1:7890 all_proxy=socks://127.0.0.1:7890 no_proxy=localhost,127.0.0.0/8,::1`

## Windows

### 依赖项

* 必选项

  * neovim ([官网](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-download), [win64](https://github.com/neovim/neovim/releases/latest/download/nvim-win64.msi))
  * git
  * mingw ([官网](https://www.mingw-w64.org/downloads/), [github](https://github.com/niXman/mingw-builds-binaries))
  * npm (node.js) ([官网](https://nodejs.cn/download/))
  * rg (ripgrep) ([官网](https://github.com/BurntSushi/ripgrep/releases/))

### 安装步骤

Install the [PithyVimart](https://github.com/qeuroal/Pithyvimart) with [PowerShell](https://github.com/PowerShell/PowerShell)

* Make a backup of your current Neovim files:

  ```powershell
  # required
  Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
  
  # optional but recommended, which makes a backup
  Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak
  ```

* Clone the starter

  ```powershell
  git clone https://github.com/qeuroal/pithyvimart.git $env:LOCALAPPDATA\nvim
  ```

* **(optional but not recommended)** Remove the `.git` folder, so you can add it to your own repo later

  ```powershell
  Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force
  ```

* Start Neovim!

  ```powershell
  nvim
  ```

> [!TIP]
> proxy
> POWERSHELL: `$Env:http_proxy="http://127.0.0.1:7890";$Env:https_proxy="http://127.0.0.1:7890";$Env:socket_proxy="http://127.0.0.1:7890";$Env:all_proxy="http://127.0.0.1:7890"`
> CMD: `set http_proxy=http://127.0.0.1:7890; set https_proxy=http://127.0.0.1:7890; set all_proxy=http://127.0.0.1:7890; set socket_proxy=http://127.0.0.1:7890`


# 插件

## 依赖项

> [!NOTE]
> 方便起见, 可以先不安装这些插件的依赖项, 如果有报错再根据错误信息安装相应的依赖项即可 (`<leader>n` 可以用来查看通知历史, 包括错误信息).

### global

#### npm

* archlinux: `sudo pacman -S --noconfirm npm`
* ubuntu: `sudo apt-get -y install npm`
* fedora: `sudo dnf install -y npm`
* macos: `brew install node`

### markdown

#### markdownlint-cli2

* archlinux: `sudo pacman -S --noconfirm markdownlint-cli2`
* macos: `brew install markdownlint-cli2`
* ubuntu: `sudo apt install markdownlint`

# 资料相关

## Nerd Fonts 字体

### 下载

* [Nerd Fonts 下载网址](https://www.nerdfonts.com/font-downloads): 包含所有常用的 Nerd Fonts 字体
* JetBrainsMono Nerd Font [点击下载](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip)
### 手动安装

* MacOS

  1. 将字体所在文件夹移动到 `~/Library/Fonts` 目录
  1. 运行命令: `fc-cache -vf`
  1. 查看字体列表: `fc-list`

* Linux:

  1. 将字体所在文件夹移动到 `~/.local/share/fonts` 目录
  1. 运行命令: `fc-cache -vf`
  1. 查看字体列表: `fc-list`

* Windows:

  1. 选中字体文件, 右键-安装

# QAs

* neovim default setting

[见 https://neovim.io/doc/user/vim_diff.html#nvim-defaults](https://neovim.io/doc/user/vim_diff.html#nvim-defaults)

* 如何查看配置路径

  ```vim
  :echo stdpath('config')
  ```

* create your [init.vim](https://neovim.io/doc/user/starting.html#init.vim) (user config) file:

  ```vim
  :exe 'edit '.stdpath('config').'/init.vim'
  :write ++p
  ```

## Common

* Error running markdownlint-cli2: ENOENT: no such file or directory

  安装 markdownlint 依赖项, 具体[见这里](#markdownlint-cli2)


## Linux

* 添加 AppImage ("universal" Linux package)

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

* Python module

  * archlinux

    The Python module is available from the community repository:

    ```bash
    sudo pacman -S python-pynvim
    ```

  * ubuntu

    Python (`:python`) support is installable via the package manager on Debian unstable.

    ```bash
    sudo apt-get install python3-neovim
    ```

  * fedora

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

* Ruby modules

  * archlinux

    (currently only supported in `neovim-git`) are available from the AUR as [`ruby-neovim`](https://aur.archlinux.org/packages/ruby-neovim).


## MacOS

* Mac 系统没有 Alt 键，Option 键也不管用，如何设置 Command 快捷键

  在我们的配置中，Mac 系统的 Option 键对应的是 Windows 系统的 Alt 键，如果你的 Option 键没有反应，通常需要设置一下你的终端，将 Option 键设置为 Meta 键。

  * Item2: 设置方式为 Preference -> Profiles -> Default --> Keys --> Left Option key --> 选中 Esc+

  * alacritty: 设置 `[window]` 的 `option_as_alt` 为 `OnlyLeft`, 如下所示:

    ```toml
    [window]
    option_as_alt = "OnlyLeft"
    ```


## Windows

* 缺失 `VCRUNTIME140.dll`

  1. If you are missing `VCRUNTIME140.dll`, install the [Visual Studio 2015 C++ redistributable](https://support.microsoft.com/en-us/kb/2977003) (choose x86_64 or x86 depending on your system).
  1. Choose a package (**nvim-winXX.zip**) from the [releases page](https://github.com/neovim/neovim/releases).
  1. Unzip the package. Any location is fine, administrator privileges are _not_ required.
  1. `$VIMRUNTIME` will be set to that location automatically.
  1. Run `nvim.exe` from a terminal.

* Windows 系统无法使用 `nvim` 编辑文件

  添加PATH: 添加 nvim 程序的 `bin` 文件夹 (e.g. `C:\Program Files\nvim\bin`) 到系统 PATH.

* 拼写检查无效

  If `:set spell` does not work, create the `C:/Users/foo/AppData/Local/nvim/site/spell` folder.

  You can then copy your spell files over (for English, located [here](https://github.com/vim/vim/blob/master/runtime/spell/en.utf-8.spl) and [here](https://github.com/vim/vim/blob/master/runtime/spell/en.utf-8.sug));

* For Python plugins you need the `pynvim` module. "Virtual envs" are recommended.

  1. After activating the virtual env do `pip install pynvim` (in _both_). Edit your `init.vim` so that it contains the path to the env's Python executable:

    ```vim
    let g:python3_host_prog='C:/Users/foo/Envs/neovim3/Scripts/python.exe'
    ```

  2. Run `:checkhealth` and read `:help provider-python`.

* windows 的 ubuntu 子系统下安装插件报错 could not find executable "unzip" in path?

  因为缺少压缩解压软件, 需要安装 zip unzip.

  ```bash
  sudo apt-get install zip unzip
  ```


## 参考

* [neovim安装官方教程](https://github.com/neovim/neovim/blob/master/INSTALL.md)
* [neovim初始化官方教程](https://neovim.io/doc/user/starting.html#_initialization)
* [nvim.html](https://neovim.io/doc/user/nvim.html)

