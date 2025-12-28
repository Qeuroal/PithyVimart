
# 使用说明

## MacOS/Linux

- `make build`: 配置 alias, env config, shell config and utils
- `make cd`: 配置 git config, ssh config and tmux config

## Windows

### 配置别名

1. 按 `Win + R`，输入 `regedit` 回车。
1. 找到路径：`HKEY_CURRENT_USER\Software\Microsoft\Command Processor`
1. 在右侧空白处右键 -> **新建** -> **字符串值**。
1. 名称命名为：`AutoRun`

   默认情况下是没有 AutoRun 这个键值的, 需要自己新建, 类型为字符串.

1. 双击它，数值数据填入你刚才创建的文件的**绝对路径**（例如 `"%USERPROFILE%\pithyvimart\assets\dotfiles\.aliases.bat"`）。

> [!NOTE]
> 命令提示符窗口下输入 `cmd /?` 打开 cmd 帮助, 向下翻, 会发现 cmd 启动的时候会搜索注册表的两个键值, 并执行这两个键值对应的命令.
>
> - 对所有用户生效: `HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\AutoRun`
> - 对当前用户生效: `HKEY_CURRENT_USER\Software\Microsoft\Command Processor\AutoRun`

