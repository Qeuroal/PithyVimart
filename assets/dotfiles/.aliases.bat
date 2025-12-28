@echo off

:: 定义开启代理的别名 (注意用 $T 分隔命令)
doskey setproxy=set "http_proxy=http://127.0.0.1:7890" $T set "https_proxy=http://127.0.0.1:7890" $T set "all_proxy=http://127.0.0.1:7890" $T set "socket_proxy=http://127.0.0.1:7890"
:: 定义关闭代理的别名
doskey unsetproxy=set "http_proxy=" $T set "https_proxy=" $T set "all_proxy=" $T set "socket_proxy="

:: nvim
doskey vi=nvim $*

