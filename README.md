# 支持

- Linux
- MacOS
- Windows

# 下载

## 预构建安装包

下载页面为 [Releases](https://github.com/neovim/neovim/releases).

- Latest [stable release](https://github.com/neovim/neovim/releases/latest)
    - [macOS x86](https://github.com/neovim/neovim/releases/latest/download/nvim-macos-x86_64.tar.gz)
    - [macOS arm](https://github.com/neovim/neovim/releases/latest/download/nvim-macos-arm64.tar.gz)
    - [Linux](https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz)
    - [Windows](https://github.com/neovim/neovim/releases/latest/download/nvim-win64.msi)
- Latest [development prerelease](https://github.com/neovim/neovim/releases/nightly)

# 安装

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

## Windows

### 依赖项

- 必选项

   - neovim ([官网](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-download), [win64](https://github.com/neovim/neovim/releases/latest/download/nvim-win64.msi))
   - git
   - mingw ([官网](https://www.mingw-w64.org/downloads/), [github](https://github.com/niXman/mingw-builds-binaries))
   - npm (node.js) ([官网](https://nodejs.cn/download/))


# 插件

## 依赖项

> [!NOTE]
> 方便起见, 可以先不安装这些插件的依赖项, 如果有报错再根据错误信息安装相应的依赖项即可 (`<leader>n` 可以用来查看通知历史, 包括错误信息).

- global

   - npm

      - archlinux: `sudo pacman -S --noconfirm npm` 
      - ubuntu: `sudo apt-get -y install npm`
      - fedora: `sudo dnf install -y npm`
      - macos: `brew install node`

- markdown

   - markdownlint-cli2

      - archlinux: `sudo pacman -S --noconfirm markdownlint-cli2` 
      - macos: `brew install markdownlint-cli2`
      - ubuntu: `sudo apt install markdownlint`

# 补充

# QAs

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

## Windows

- 缺失 `VCRUNTIME140.dll`

   1. If you are missing `VCRUNTIME140.dll`, install the [Visual Studio 2015 C++ redistributable](https://support.microsoft.com/en-us/kb/2977003) (choose x86_64 or x86 depending on your system).
   2. Choose a package (**nvim-winXX.zip**) from the [releases page](https://github.com/neovim/neovim/releases).
   3. Unzip the package. Any location is fine, administrator privileges are _not_ required.
   - `$VIMRUNTIME` will be set to that location automatically.
   4. Run `nvim.exe` from a terminal.

- Windows 系统无法使用 `nvim` 编辑文件

   添加PATH: 添加 nvim 程序的 `bin` 文件夹 (e.g. `C:\Program Files\nvim\bin`) 到系统 PATH.

- 拼写检查无效

   If `:set spell` does not work, create the `C:/Users/foo/AppData/Local/nvim/site/spell` folder.

   You can then copy your spell files over (for English, located [here](https://github.com/vim/vim/blob/master/runtime/spell/en.utf-8.spl) and [here](https://github.com/vim/vim/blob/master/runtime/spell/en.utf-8.sug));

- For Python plugins you need the `pynvim` module. "Virtual envs" are recommended.

   1. After activating the virtual env do `pip install pynvim` (in *both*). Edit your `init.vim` so that it contains the path to the env's Python executable:

      ```vim
      let g:python3_host_prog='C:/Users/foo/Envs/neovim3/Scripts/python.exe'
      ```

   2. Run `:checkhealth` and read `:help provider-python`.


## 参考

- [官网文档](https://github.com/neovim/neovim/blob/master/INSTALL.md)
