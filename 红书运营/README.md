# 红书运营 — 心灵角落 · April 五人团队

**给别人用 / 要上 GitHub**：从新建远程仓库、push、`git clone` 到第一篇选题的**完整说明** → **[`docs/GitHub上传与运行指南.md`](docs/GitHub上传与运行指南.md)**。

**clone 后不知道从哪装、Key 放哪、路径对不对**（无 `package.json` 是正常的）→ **[`docs/协作者从clone到第一句话.md`](docs/协作者从clone到第一句话.md)**。

**只想按步骤照做、发给对方对接** → **[`docs/协作者复制即用-跑通步骤.md`](docs/协作者复制即用-跑通步骤.md)**。

若 GitHub 仓库 **第一层只有「红书运营」子文件夹**，请先 `cd 红书运营` 再当作项目根（须与 `CLAUDE.md` 同级）。

## 运行方式：本地 CLI / Claude Code（网页或桌面）/ Web IDE

| 你怎么用 | 本机 `~/.secrets` | 典型步骤 |
|----------|-------------------|----------|
| **Claude Code / Cursor，打开含 `CLAUDE.md` 的工作区**（含浏览器里、Codespaces 等） | 通常**不必**；由**平台或客户端**负责鉴权（仍可能要你在设置里填网关/Key） | 把工作区根设为 **`CLAUDE.md` 所在目录** → 读 **[`CLAUDE.md`](CLAUDE.md)** → 在对话里用**自然语言触发语**（如「开始今天的工作」），勿假定 Markdown 自带统一的「Run」按钮（因产品而异）。 |
| **本地终端 + `claude` CLI** | **A** 能直连时可依赖官方登录；**B** 国内中转时建议用 **`~/.secrets/hongshu_claude.env`**（见协作者文档） | `git clone` → `cd` 到项目根 → `sh ./routines/bootstrap_after_clone.sh` → 按 **[协作者文档 A/B](docs/协作者从clone到第一句话.md)** 配环境 → `claude`（或 `claude --bare --agents "$(cat routines/agents.json)"`，见 `CLAUDE.md`） |

**不要**把真实 API Key 写进仓库或提交 `.env`；网络采风仍遵守 **`routines/网络采风白名单.md`**。本仓**默认不设**「在 GitHub Actions 里自动跑选题」——若将来要做，须在仓库 Secrets、费用与合规上单独评估。

## 新人文档从哪里读起

| 你想… | 打开 |
|--------|------|
| **只复制步骤、尽快跑通（推荐先发对方）** | [`docs/协作者复制即用-跑通步骤.md`](docs/协作者复制即用-跑通步骤.md) |
| 最短上手（含 A/B 接法、通关话术） | [`docs/协作者从clone到第一句话.md`](docs/协作者从clone到第一句话.md) |
| Git clone / push / 给别人的检查清单 | [`docs/GitHub上传与运行指南.md`](docs/GitHub上传与运行指南.md) |
| 本机 Cursor / CLI / Key 细节 | [`docs/上手运行指南.md`](docs/上手运行指南.md) |
| 口令、禁止项、子 Agent | [`CLAUDE.md`](CLAUDE.md) |
| 当天逐步点选（给人看的清单，非可执行脚本） | [`routines/每日操作清单.md`](routines/每日操作清单.md) |

**只关心本机怎么配**：克隆后环境与 Cursor / Claude CLI → **[`docs/上手运行指南.md`](docs/上手运行指南.md)**。

- **环境约定**：密钥不放在仓库里的 `.env`，本机 CLI 推荐 **`~/.secrets/hongshu_claude.env`**；模板见 [`.secrets/hongshu_claude.env.example`](.secrets/hongshu_claude.env.example)。Web IDE 以平台配置为准。
- **clone 后建目录**（可选）：在项目根执行 `sh ./routines/bootstrap_after_clone.sh`。

能直连官方 / 国内需网关的**双轨说明**全文仍见 **[`docs/协作者从clone到第一句话.md`](docs/协作者从clone到第一句话.md)**。

- **构想全文**：[`构想.md`](构想.md)  
- **人设与禁忌**：[`aboutme.md`](aboutme.md)（已按《构想》同步一版，可直接用；口癖/颜色等可再改）  
- **Claude Code 规则**：[`CLAUDE.md`](CLAUDE.md)  
- **每日**：终端说 **「开始今天的工作」** → 选题 April **MCP 白名单采风**（见 `routines/网络采风*.md`）→ `日记/…/选题建议.md`（含正版渠道）；**可选**先写 [`角落素材/`](角落素材/) 当天 `raw` 舵向  
- **逐步操作（在哪儿做什么）**：[`routines/每日操作清单.md`](routines/每日操作清单.md)

## 目录速览

| 路径 | 用途 |
|------|------|
| `日记/YYYY-MM-DD/` | 当日选题、文案、设计、发布、复盘 |
| `角落素材/` | 你投喂：书/影/歌、心情、链接 |
| `数据输入/` | 后台数据、CSV 说明或粘贴 |
| `内容库/published/` | 已发布元数据归档 |
| `routines/` | `agents.json`、敏感词、检查清单、栏目模板、[每日操作清单](routines/每日操作清单.md) |
| `docs/` | [复制即用-跑通步骤](docs/协作者复制即用-跑通步骤.md)、[协作者三段式](docs/协作者从clone到第一句话.md)、[GitHub 上传与运行](docs/GitHub上传与运行指南.md)、[上手运行指南](docs/上手运行指南.md) |
| `.secrets/` | 仅本地密钥说明（勿提交真实值） |
