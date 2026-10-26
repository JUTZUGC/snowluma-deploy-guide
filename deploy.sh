#!/usr/bin/env bash
set -euo pipefail
# SnowLuma 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://snowluma.github.io/zh/docs/guide/deploy
# 更新日期：2026-10-26
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

[ "$(uname -s)" = "Linux" ] || { echo "官方只提供 Windows / Linux 发行包；macOS 请用 Docker 方案"; exit 1; }
case "$(uname -m)" in x86_64) url=https://github.com/SnowLuma/SnowLuma/releases/download/v2.2.0/SnowLuma-v2.2.0-linux-x64.tar.gz ; want=88fb5ac65df552ae25f6508cc9e807c11f30247cf35e819867560e05a36cd4e3 ;; aarch64|arm64) url=https://github.com/SnowLuma/SnowLuma/releases/download/v2.2.0/SnowLuma-v2.2.0-linux-arm64.tar.gz ; want=1730fc2546aa745c066cae84a3fd16107d46ee0aa4a1f6c692fbc342e55d1ffa ;; *) echo "不支持的 CPU 架构"; exit 1 ;; esac
curl -fL -o SnowLuma.tar.gz "$url"
echo "$want  SnowLuma.tar.gz" | sha256sum -c -
tar -xzf SnowLuma.tar.gz ; chmod +x launcher.sh ; echo "解压完成：运行 ./launcher.sh，然后打开 http://127.0.0.1:5099"

echo ""

echo "安装完成：Windows 运行 launcher.bat，Linux 运行 ./launcher.sh；然后打开 http://127.0.0.1:5099，用启动日志里的初始密码登录"
echo "若结果异常或需要改配置，请参考官方文档：https://snowluma.github.io/zh/docs/guide/deploy"
