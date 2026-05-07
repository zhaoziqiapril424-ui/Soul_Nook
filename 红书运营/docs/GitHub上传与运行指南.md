# GitHub 上传与运行指南

本文说明：**如何把「心灵角落 / 红书运营」模板推到 GitHub**，以及 **协作者 clone 下来后如何从零跑通工作流**。  
更细的环境与命令说明见同目录下的 **[`上手运行指南.md`](上手运行指南.md)**；口令串流见 **[`../routines/一键口令工作流.md`](../routines/一键口令工作流.md)**。

---

## 这个模板在做什么？

这是一个 **用 Markdown 组织的小红书内容生产仓**：在 Cursor 或 Claude Code 里用自然语言驱动 **选题 → 文案 → 设计说明 → 发布自检**，产出写入 **`日记/YYYY-MM-DD/`**。  
**默认不自动发帖**；配图通常用即梦等工具按 `设计稿.md` 里的 brief 手工生成，不必接生图 API。

**必读规则文件**：[`aboutme.md`](../aboutme.md)（人设与禁忌）、[`CLAUDE.md`](../CLAUDE.md)（触发语与禁止项）。

---

## 一、仓库应当是哪一种目录结构？

**正确**：Git 仓库的根目录下**第一层**就能看到 **`CLAUDE.md`**、**`README.md`**、**`routines/`**、`日记/` 等。

```text
（clone 后 cd 进入的这一层 = 项目根）
├── README.md
├── CLAUDE.md
├── aboutme.md
├── .cursor/
├── .gitignore
├── routines/
├── docs/
├── 日记/
├── 角落素材/
├── 内容库/
└── …
```

**判断方法**：在 Cursor 里用 **File → Open Folder** 打开 **含有 `CLAUDE.md` 的那一层**。若多包了一层目录，Agent 读的路径会对不上说明里的「项目根」。

**注意**：若本地曾解压出 **「外层文件夹里又套了一个同名子文件夹」** 的副本，请只保留 **一份** 作为 Git 根目录，避免改错目录；多余的副本不要 `git add`，或按需写入你自己的 `.gitignore`。

---

## 二、推送到 GitHub：作者侧步骤

### 2.1 推送前检查（必做）

| 检查项 | 说明 |
|--------|------|
| 无密钥 | 确认仓库内 **没有** API Key、Cookie、Token、内网 URL；密钥只放在本机如 `~/.secrets/hongshu_claude.env`（勿提交） |
| `.gitignore` | `.secrets/*`（保留说明文件）、`assets/generated/*`（保留 `.gitkeep`）、`routines/logs/` 等已被忽略 |
| 大包与备份 | 不要把 `.zip` 备份误 `git add`；需要时已用根目录 `.gitignore` 忽略 `*.zip` |
| 日记与素材 | 若不想公开某天的草稿，可用私有仓，或对 `日记/` 做单独忽略策略（团队自行约定） |

### 2.2 在 GitHub 新建仓库

1. GitHub 上 **New repository**，若本地已有完整树，可 **不** 勾选「自动添加 README」，避免首轮冲突。
2. 记下远端地址，例如 `https://github.com/你的用户名/xinlingjiaoluo.git` 或 SSH 等价地址。

### 2.3 本地首次关联并推送

在项目根（含 `CLAUDE.md` 的那一层）执行：

```bash
git status
git add -A
git commit -m "Initial commit: 心灵角落红书运营模板"
git branch -M main
git remote add origin https://github.com/你的用户名/仓库名.git
git push -u origin main
```

若远程已有提交，需先 `git pull origin main --rebase` 再 push，或按团队流程处理。

---

## 三、协作者侧：clone 后怎么跑起来？

以下五步与 **[`上手运行指南.md`](上手运行指南.md)** 一致，这里做 **最短路径** 摘要。

### 步骤 1：克隆并进入项目根

```bash
git clone https://github.com/你的用户名/仓库名.git
cd 仓库名
```

确认当前目录下有 **`CLAUDE.md`**。

### 步骤 2：准备 API（Claude Code CLI 或兼容端点）

1. 在服务商控制台创建 **API Key**（勿写入仓库）。
2. 本机创建私密 env 文件（示例路径与仓库脚本一致）：

```bash
mkdir -p ~/.secrets
chmod 700 ~/.secrets
# 编辑 ~/.secrets/hongshu_claude.env，例如：
# export ANTHROPIC_API_KEY="…"
# 若用兼容网关：export ANTHROPIC_BASE_URL="…"
chmod 600 ~/.secrets/hongshu_claude.env
```

说明见 [`.secrets/README.md`](../.secrets/README.md)。

### 步骤 3：安装工具（按需）

| 工具 | 作用 |
|------|------|
| [Cursor](https://cursor.com/)（推荐）或 VS Code | 打开项目根；规则在 `.cursor/rules/` |
| [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code/overview)（`claude`） | 与 `routines/agents.json` 子 Agent 流程一致 |
| Python 3 | 仅在使用 `routines/daily_run_topic_april.sh` 时需要 |
| MCP Fetch（可选） | 选题「网络采风」：只允许 [`网络采风白名单.md`](../routines/网络采风白名单.md) 内域名 |

### 步骤 4：用 Cursor（推荐新手）

1. **Open Folder** → 选项目根。  
2. 在 Chat / Agent 里发送 **[`CLAUDE.md`](../CLAUDE.md)** 中的口令，例如：**「开始今天的工作」**、**「今天发什么」**。  
3. 模型会按 **`aboutme.md`** 与 **`routines/`** 下规则读写 **`日记/YYYY-MM-DD/`**。

### 步骤 5：用终端 + Claude Code CLI

```bash
cd /你的路径/仓库名
source ~/.secrets/hongshu_claude.env
claude --bare --agents "$(cat routines/agents.json)"
```

进入交互后同样使用 **`CLAUDE.md`** 中的触发语。若 `--agents` 传入报错，可参考 `routines/daily_run_topic_april.sh` 里用 `python3` 将 JSON 压成单行的写法。

---

## 四、产出物与常用口令（对照表）

| 你说 / 做的 | 典型产出文件 |
|-------------|----------------|
| 「早上好」「开始今天的工作」 | `日记/YYYY-MM-DD/选题建议.md` |
| 「用方案 N」「选题定第 N 个」 | `文案初稿.md` |
| 「文案定稿，做图」 | `设计稿.md`（+ `assets/generated/` 说明，若用了出图流程） |
| 「终稿，走发布检查」 | `发布日志.md` + 检查项（**仍不自动发帖**） |
| 「数据已贴，写复盘」 | `数据复盘.md`；按 **`CLAUDE.md`** 约定只 **追加** `aboutme.md` 的「账号迭代记录」 |

**一键日更**：**「今天发什么」** 按 **[`一键口令工作流.md`](../routines/一键口令工作流.md)** 尽量串完选题 → 文案 → 设计；无人拍板时默认方案与 **`aboutme.md`** 中关于方案 1 的约定一致。

可选：每天在 **`角落素材/`** 放置 **`YYYY-MM-DD-raw.md`** 作为选题舵向（没有也可）。

更细的逐步清单：**[`每日操作清单.md`](../routines/每日操作清单.md)**。

---

## 五、可选：定时只跑「选题」

macOS 可用 **launchd** + **`routines/daily_run_topic_april.sh`** 在固定时刻生成当日 **`选题建议.md`**，**不写**文案/设计/发帖。  
完整步骤见 **[`每日选题自动化.md`](../routines/每日选题自动化.md)**。日志在 `routines/logs/`（已默认忽略，勿提交隐私日志）。

---

## 六、合规与安全（公开仓库尤需注意）

- **禁止**在仓库中出现盗版资源链接、需登录爬取、破解付费墙流程。  
- 网络请求只按 **[`网络采风白名单.md`](../routines/网络采风白名单.md)** 与 **[`网络采风规则.md`](../routines/网络采风规则.md)** 执行。  
- 默认 **不** 调用小红书发帖 API；配图避免 1:1 复刻官方海报（见 **`aboutme.md`**）。

---

## 七、文档索引（给别人看时贴这一段）

| 文档 | 用途 |
|------|------|
| [`README.md`](../README.md) | 总览与目录说明 |
| [`docs/上手运行指南.md`](上手运行指南.md) | 本机配置、Cursor/CLI、API Key 细节 |
| **本文** | GitHub 发布 + clone 后最短跑通路径 |
| [`CLAUDE.md`](../CLAUDE.md) | 触发语、禁止项、Subagent 启动示例 |
| [`aboutme.md`](../aboutme.md) | 账号叙事与人设真源（fork 后请改为你自己的） |

Fork 使用后，建议把 **`aboutme.md`**、**`品牌资产/`**、**`构想.md`** 换成你自己的账号设定，并保留 **`CLAUDE.md`** / **`routines/`** 的工作流骨架以便 Agent 稳定执行。
