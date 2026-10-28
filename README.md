# SnowLuma 一键部署指南

> 第三方部署指南 · 非 SnowLuma 官方仓库。官方项目：[SnowLuma/SnowLuma](https://github.com/SnowLuma/SnowLuma)
> 内容来自官方文档（2026-10-28）。项目迭代快，请以[官方文档](https://snowluma.github.io/zh/docs/guide/deploy)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 不用自己找协议端，让百度搭子下载校验解压，启动后接上本机 QQ 就能用。

⚠️ 支持 Windows / Linux（macOS 建议用 Docker）。需要本机已安装并登录 QQ 客户端；WebUI 默认 5099，初始密码在启动日志里。第三方 QQ 协议桥，不符合 QQ 用户协议，存在封号风险。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/snowluma-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按系统下载完整发行包、核对 SHA256，Windows 上自动解压，Linux 上解压并加执行权限，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## SnowLuma 是什么？

SnowLuma 是开源的把 QQ 会话桥接成 OneBot v11 的运行时（协议：自定义 EULA，<img src="https://img.shields.io/github/stars/SnowLuma/SnowLuma?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

把本机 QQ 的原生会话转成 OneBot v11 动作与事件，通过 WebSocket / HTTP / WebUI 暴露给 AstrBot、LangBot 这类机器人框架；支持多账号、消息与媒体、WebUI 调试，另有 SDK 与 MCP 包。

- 接口：OneBot v11（WS 服务端 / 客户端、HTTP 服务端 / 上报）
- 消息：文本、图片、语音、视频、文件、回复、提及、转发与常见卡片
- 多账号：会话、身份映射、消息存储、网络配置各自独立
- WebUI：账号状态、实时日志、连接配置、动作调试
- 扩展：`@snowluma/sdk` 与 `@snowluma/mcp`

（来源：[官方仓库](https://github.com/SnowLuma/SnowLuma)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 3.0k stars | 每天有提交，生态里被广泛引用 |
| 补齐链路 | AstrBot / LangBot 接 QQ 就差这一层 |
| 多账号 | 会话、存储、连接各自隔离 |
| WebUI 完善 | 日志、调试、连接配置都在面板里 |
| 有 SDK 与 MCP | 方便二次开发和接 Agent |

| 需要注意 | 说明 |
|---|---|
| 封号风险 | 非官方 QQ 协议，违反用户协议 |
| 协议不标准 | 自定义 EULA，不是 MIT / Apache |
| 依赖本机 QQ | 需要登录的 QQ 客户端，不是纯服务端 |
| macOS 没原生包 | 只能走 Docker |
| Lite 包有版本要求 | 需要 Node.js 24+ |
| star 基数不大 | 2.7k，但周边项目多 |

> 以上基于官方文档与社区反馈整理（2026-10-28），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
[ "$(uname -s)" = "Linux" ] || { echo "官方只提供 Windows / Linux 发行包；macOS 请用 Docker 方案"; exit 1; }
case "$(uname -m)" in x86_64) url=https://github.com/SnowLuma/SnowLuma/releases/download/v2.2.1/SnowLuma-v2.2.1-linux-x64.tar.gz ; want=93a30395c8cc7c39d1061fd1ad841a4382921a6bc7833725857805c4f2e98b4d ;; aarch64|arm64) url=https://github.com/SnowLuma/SnowLuma/releases/download/v2.2.1/SnowLuma-v2.2.1-linux-arm64.tar.gz ; want=26727d30109a5a7cc19e95f7c7a7ca9cbf9eb17adce7c122129e96bda88a2945 ;; *) echo "不支持的 CPU 架构"; exit 1 ;; esac
curl -fL -o SnowLuma.tar.gz "$url"
echo "$want  SnowLuma.tar.gz" | sha256sum -c -
tar -xzf SnowLuma.tar.gz ; chmod +x launcher.sh ; echo "解压完成：运行 ./launcher.sh，然后打开 http://127.0.0.1:5099"
```

安装包来源：[https://github.com/SnowLuma/SnowLuma#快速开始](https://github.com/SnowLuma/SnowLuma#快速开始)

## 验证状态

| 场景 | 状态 |
|---|---|
| Release v2.2.1 的 Windows / Linux 包与 SHA256 digest 已核对 | 已核对 2026-10-28 |
| 未下载运行（桥接需要已登录的 QQ，本机无测试账号） | 已核对 2026-10-26 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-26 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-26 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目提供 `@snowluma/mcp` 包，可把能力以 MCP 形式暴露给 Agent。本仓库的 MCP 只提供下载、校验与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-28）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\snowluma-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 启动之后

1. 运行 `launcher.bat`（Windows）或 `./launcher.sh`（Linux），日志里会打印 WebUI 初始密码
2. 打开 [http://127.0.0.1:5099](http://127.0.0.1:5099) 登录，按引导接入本机 QQ 进程
3. 在 WebUI 里配 OneBot 连接：WS 服务端或 HTTP 上报，把地址填到 AstrBot / LangBot 的 OneBot 配置里
4. 多账号：每个 QQ 独立配置会话与连接

### 和机器人框架搭配

```text
SnowLuma（QQ ↔ OneBot v11） → AstrBot / LangBot（对话与插件） → 大模型
```

### 包怎么选

| 包 | 说明 |
|---|---|
| `win-x64.zip`（41.0 MB） | Windows 完整包，自带运行时 |
| `win-x64-lite.zip`（6.5 MB） | 精简包，需要 Node.js 24+ |
| `linux-x64.tar.gz`（50.1 MB） | Linux x64 完整包 |
| `linux-arm64.tar.gz`（49.7 MB） | Linux ARM64 完整包 |

> ⚠️ 第三方 QQ 协议桥不符合《QQ 用户协议》，存在封号风险；建议用小号测试，不要在主账号上跑自动化。

## 常见坑

- 打不开 5099：先确认 launcher 没报错，初始密码只在启动日志里打印一次
- 接入 QQ 失败：确认 QQ 已登录，且版本与 SnowLuma 兼容
- OneBot 连不上：检查 WS / HTTP 地址与端口，别把 5099 当成 OneBot 端口
- macOS 用户：没有原生发行包，按官方文档用 Docker
- Lite 包启动失败：需要 Node.js 24+，完整包自带运行时
- 封号风险自担：不要在主账号上跑高频自动化
- 升级前备份配置与消息存储，删包重装会丢数据

## 免责声明

本仓库为第三方指南，与 SnowLuma 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-28），项目迭代快，请以[官方文档](https://snowluma.github.io/zh/docs/guide/deploy)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
