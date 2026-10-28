#!/usr/bin/env bash
set -euo pipefail
# SnowLuma 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://snowluma.github.io/zh/docs/guide/deploy
# 更新日期：2026-10-28
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

[ "$(uname -s)" = "Linux" ] || { echo "官方只提供 Windows / Linux 发行包；macOS 请用 Docker 方案"; exit 1; }
case "$(uname -m)" in x86_64) url=https://github.com/SnowLuma/SnowLuma/releases/download/v2.2.1/SnowLuma-v2.2.1-linux-x64.tar.gz ; want=93a30395c8cc7c39d1061fd1ad841a4382921a6bc7833725857805c4f2e98b4d ;; aarch64|arm64) url=https://github.com/SnowLuma/SnowLuma/releases/download/v2.2.1/SnowLuma-v2.2.1-linux-arm64.tar.gz ; want=26727d30109a5a7cc19e95f7c7a7ca9cbf9eb17adce7c122129e96bda88a2945 ;; *) echo "不支持的 CPU 架构"; exit 1 ;; esac
curl -fL -o SnowLuma.tar.gz "$url"
echo "$want  SnowLuma.tar.gz" | sha256sum -c -
tar -xzf SnowLuma.tar.gz ; chmod +x launcher.sh ; echo "解压完成：运行 ./launcher.sh，然后打开 http://127.0.0.1:5099"

echo ""

echo "安装完成：Windows 运行 launcher.bat，Linux 运行 ./launcher.sh；然后打开 http://127.0.0.1:5099，用启动日志里的初始密码登录"
echo "若结果异常或需要改配置，请参考官方文档：https://snowluma.github.io/zh/docs/guide/deploy"
