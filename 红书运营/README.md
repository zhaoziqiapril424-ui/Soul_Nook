# 红书运营 — 心灵角落 · April 五人团队

**给别人用 / 要上 GitHub**：从新建远程仓库、push、`git clone` 到第一篇选题的**完整说明** → **[`docs/GitHub上传与运行指南.md`](docs/GitHub上传与运行指南.md)**。

**clone 后不知道从哪装、Key 放哪、路径对不对**（无 `package.json` 是正常的）→ **[`docs/协作者从clone到第一句话.md`](docs/协作者从clone到第一句话.md)**。

**只关心本机怎么配**：克隆后环境与 Cursor / Claude CLI → **[`docs/上手运行指南.md`](docs/上手运行指南.md)**。

- **环境约定**：密钥不放在仓库里的 `.env`，请用 **`~/.secrets/hongshu_claude.env`**；可复制的空模板见 [`.secrets/hongshu_claude.env.example`](.secrets/hongshu_claude.env.example)。
- **clone 后一次性建齐目录**（可选）：在项目根执行 `./routines/bootstrap_after_clone.sh`。

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
| `docs/` | [GitHub 上传与运行](docs/GitHub上传与运行指南.md)、[协作者三段式](docs/协作者从clone到第一句话.md)、[上手运行指南](docs/上手运行指南.md) |
| `.secrets/` | 仅本地密钥说明（勿提交真实值） |
