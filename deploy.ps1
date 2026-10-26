# SnowLuma 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://snowluma.github.io/zh/docs/guide/deploy
# 更新日期：2026-10-26
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -L --fail -o SnowLuma.zip https://github.com/SnowLuma/SnowLuma/releases/download/v2.2.0/SnowLuma-v2.2.0-win-x64.zip
$h = (Get-FileHash -Algorithm SHA256 SnowLuma.zip).Hash.ToLower() ; if ($h -ne '4e293f1e4452c9ae0d8a8d4f065dea8a170ca64502f2d6d4bff8f92a826b5f75') { throw "SHA256 校验失败，文件可能不完整，请重试" }
Expand-Archive -Path SnowLuma.zip -DestinationPath SnowLuma -Force ; Write-Host '已解压：进入 SnowLuma 目录运行 launcher.bat，然后打开 http://127.0.0.1:5099'

Write-Host ''

Write-Host '安装完成：Windows 运行 launcher.bat，Linux 运行 ./launcher.sh；然后打开 http://127.0.0.1:5099，用启动日志里的初始密码登录'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://snowluma.github.io/zh/docs/guide/deploy'
