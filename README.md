# 支持

- Linux
- MacOS
- Windows

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


