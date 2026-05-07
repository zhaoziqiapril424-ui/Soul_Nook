# 协作者速查：从 clone 到说第一句口令

写给 **clone 下来后不知道从哪下手** 的人：用「迷茫期 → 配置期 → 运行期」三段走完即可。更细的逐步说明仍见 [**上手运行指南**](上手运行指南.md)。

---

## 迷茫期：要装什么？有没有 package.json？

**没有 `package.json` 是正常的。** 本仓是 **Markdown + Cursor / Claude CLI 驱动** 的内容工作流，不是 Node 前端项目，**不需要** `npm install`。

| 你需要 | 是否必须 | 用途 |
|--------|----------|------|
| **Git** | 是 | clone |
| **Cursor**（或 VS Code） | 推荐 | 打开项目根，用 Chat / Agent 跑口令 |
| **Python 3** | 可选 | 只有跑 [`routines/daily_run_topic_april.sh`](../routines/daily_run_topic_april.sh) 或 launchd 定时选题时要 |
| **Claude Code CLI**（`claude`） | 可选 | 与 [`routines/agents.json`](../routines/agents.json) 子 Agent 一致；只用 Cursor 也可 |

**MCP / 网络采风**：可选；规则见 [`routines/网络采风白名单.md`](../routines/网络采风白名单.md)。

---

## 配置期：API Key 填哪？为什么不是项目里的 `.env`？

**不要把 Key 写在仓库目录里**（包括项目根下的 `.env`），避免误提交。

约定路径（与脚本、文档一致）：

1. 本机创建：`mkdir -p ~/.secrets && chmod 700 ~/.secrets`
2. 复制示例改名：仓库里有 [`.secrets/hongshu_claude.env.example`](../.secrets/hongshu_claude.env.example) → 复制为 **`~/.secrets/hongshu_claude.env`**，`chmod 600`，编辑填入真实变量。
3. 详见 [`.secrets/README.md`](../.secrets/README.md)。

**Cursor 里用自带模型时**：可能在 Cursor 设置里配 Key，与 `~/.secrets/` 是两套；终端跑 `claude` 时仍需 `source ~/.secrets/hongshu_claude.env`。

---

## 运行期：路径错了、AI 说找不到文件夹？

**一切路径相对于「项目根」**：即 **含有 `CLAUDE.md` 的那一层**（与 `README.md` 同级）。在 Cursor 里请 **File → Open Folder** 只打开这一层，不要打开上级「文档」之类的大文件夹。

clone 后建议在本机执行一次（在项目根）：

```bash
./routines/bootstrap_after_clone.sh
```

用于创建常用目录（若已存在则跳过），减少「素材 / 日记目录不存在」类问题。

产出默认约定：

- 当日内容：**`日记/YYYY-MM-DD/`**（由 Agent 或你手动建日期文件夹）
- 可选舵向：**`角落素材/YYYY-MM-DD-raw.md`**
- 生成图说明：**`assets/generated/`**（大文件通常不提交，见 `.gitignore`）

若仍报错，先核对：终端里 `pwd` 是否是含 `CLAUDE.md` 的目录；Agent 是否按 [`CLAUDE.md`](../CLAUDE.md) 使用相对路径 `日记/`、`角落素材/` 等。

---

## 三句就够的「第一天」

1. 打开 **含 `CLAUDE.md` 的项目根**。  
2. 配置好 **`~/.secrets/hongshu_claude.env`**（见上）。  
3. 在 Cursor Chat 里发一句：**「开始今天的工作」**（见 `CLAUDE.md` 触发语表）。

---

## 和另外几篇文档怎么配合？

| 文档 | 何时读 |
|------|--------|
| [**上手运行指南**](上手运行指南.md) | 需要逐步配环境、终端命令完整版 |
| [**GitHub上传与运行指南**](GitHub上传与运行指南.md) | 作者 push；别人 `git clone` 最短路径 |
| [**协作者从clone到第一句话**](协作者从clone到第一句话.md) | **本文**：三段式心理路径（你正在读的） |
