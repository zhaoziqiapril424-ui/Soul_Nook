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

**Claude Code 怎么接 API**：能直连官方 → 下文配置期 **A**；国内/需中转 → **B**。

**MCP / 网络采风**：可选；规则见 [`routines/网络采风白名单.md`](../routines/网络采风白名单.md)。

---

## 配置期：API Key 填哪？为什么不是项目里的 `.env`？

**不要把 Key 写在仓库目录里**（包括项目根下的 `.env`），避免误提交。细则见 [`.secrets/README.md`](../.secrets/README.md)。

**Cursor 里用自带模型时**：可能在 Cursor 设置里配 Key，与 `~/.secrets/` 是两套；终端跑 `claude` 时是否要先 `source ~/.secrets/hongshu_claude.env`，取决于你属于下面 **A** 还是 **B**。

### 两种接法：Claude Code 直连 vs 国内/兼容 API

#### A. 直接用 Claude Code（网络可直连官方，或本机已能正常登录）

适用：你能按 [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code/overview) 官方方式完成登录或凭证配置，终端里 **`claude`** 已可正常使用，**不要求**先配中转。

**最简步骤：**

1. 终端进入 **项目根**（与 **`CLAUDE.md`** 同级；多一层 **`红书运营`** 时先 `cd` 进去）。  
2. 可选：`sh ./routines/bootstrap_after_clone.sh` 预建目录。  
3. 在同一目录启动：**`claude`**（若你用子 Agent，见 [`CLAUDE.md`](../CLAUDE.md) 中的示例）。  
4. 说出第一句口令，例如：**「开始今天的工作」**。

**这时通常不必** 复制 `~/.secrets/hongshu_claude.env` 模板——除非你还要跑本仓的 **[`routines/daily_run_topic_april.sh`](../routines/daily_run_topic_april.sh)** / launchd（脚本会读该文件），或你希望与团队统一用同一套环境文件。

#### B. 国内网络 / 无法直连官方，需走兼容网关（中转 API）

适用：访问 Anthropic 官方 API 不稳定或不可用，但你的服务商提供 **Anthropic 兼容接口**（具体 URL、Key 格式以**服务商文档**为准）。

**要点：**

1. 需要两个环境变量（名称与 Claude Code / 本仓脚本对齐）：  
   - **`ANTHROPIC_BASE_URL`** — 兼容网关的 base URL（勿把内网测试地址写进仓库）。  
   - **`ANTHROPIC_API_KEY`** — 网关发放的 Key（或等价 Token）。  
2. **推荐** 写入 **`~/.secrets/hongshu_claude.env`**（`mkdir` / `chmod` / `cp` 模板见下文「交接专用」），编辑时记得 **`export`** 两行变量。  
3. **每次**新开终端要先：  
   `source ~/.secrets/hongshu_claude.env`  
   再在同一 shell 里 **`cd` 到项目根** 并执行 **`claude`**。  
4. 网关示例（智谱 Anthropic 兼容）见 **[`routines/每日选题自动化.md`](../routines/每日选题自动化.md)** 第一节；**若你用的不是智谱，请改为你服务商给出的 URL**，并自行核对路径是否仍为 `/api/anthropic` 等。  
5. 合规与采风：只用**有授权**的渠道；仓库内 **[网络采风白名单](../routines/网络采风白名单.md)** 仍单独约束 HTTP 拉取范围，与 API 网关不是一回事。

**若 B 路径仍连不上**：再查 Key 是否有效、网关是否需代理、以及服务商是否封锁了你当前网络环境。

---

### 交接专用：第三步「密钥保险箱」快速通关

**何时需要下面整段？** 多数情况下 **B（国内/网关）**、以及要跑 **定时选题脚本** 的人要按此做；**仅 A 且只交互用 `claude`** 的用户可跳过，仅保留「两种接法」里的最简步骤即可。

**为什么你在项目文件夹里找不到现成的 `.env` / 填好的 secrets？**  
这是刻意做的 **物理隔离**：真 Key 只放在你电脑的 **家目录** **`~/.secrets/hongshu_claude.env`**，与代码仓库分开。误删项目、把仓库公开到网上，Key 仍只在本机。仓库里只有模板 [`.secrets/hongshu_claude.env.example`](../.secrets/hongshu_claude.env.example)。

#### 1. 快速初始化命令

在 **项目根**（即 **`CLAUDE.md` 所在目录**）打开终端，依次执行：

```bash
# 创建「保险箱」目录并限制权限（建议仅本人可读写）
mkdir -p ~/.secrets && chmod 700 ~/.secrets

# 从仓库模板复制配置文件（避免手敲变量名拼错）
cp .secrets/hongshu_claude.env.example ~/.secrets/hongshu_claude.env

# 保护配置文件本身权限
chmod 600 ~/.secrets/hongshu_claude.env
```

#### 2. 填入密钥

用编辑器（VS Code / Cursor 等）打开 **`~/.secrets/hongshu_claude.env`**：

- 将 **`ANTHROPIC_API_KEY`** 换成你自己的 Claude（或兼容服务）Key。  
- 若使用 **国内/兼容网关**，务必按模板填写 **`ANTHROPIC_BASE_URL`**（说明见 [`routines/每日选题自动化.md`](../routines/每日选题自动化.md)）。

模板里的 **`export`** 前缀便于你在终端执行 **`source ~/.secrets/hongshu_claude.env`** 后，**`claude` 等子进程**能继承到变量。

#### 3. 激活并开始

- **用 Cursor 打开项目时**：配置保存后建议 **重启 Cursor**（或新开 Chat），再发口令 **「开始今天的工作」**（更多见 [`CLAUDE.md`](../CLAUDE.md)）。  
- **只用 Claude Code（终端）时**：若属 **A（直连）**，一般直接 **`claude`** 即可；若属 **B（网关）**，务必先在同一终端执行 **`source ~/.secrets/hongshu_claude.env`**，再 **`claude`**。

**预期结果**：在 **`日记/`** 下出现 **当天日期**（`YYYY-MM-DD`）子文件夹，其中有经规则采风后写好的 **`选题建议.md`**（具体表述因模型与网络而异，以实际生成为准）。

---

**这样设计的原因（简要）**

| 做法 | 作用 |
|------|------|
| **`chmod 700` / `chmod 600`** | 降低同机其他账户或误拷贝时读到你 Key 的概率。 |
| **`cp` 模板而非空文件手抄** | 变量名（如 **`ANTHROPIC_BASE_URL`**）与脚本、定时任务一致，少一处拼写就少一处「明明配了却读不到」的坑。 |
| **明确「日记 + 选题建议」预期** | 方便你判断链路是否真正跑通，而不是「没报错但不知道成功了没有」。 |

---

**若暂时无法 `cp` 模板**（例如只拿到口头说明），可手动新建 **`~/.secrets/hongshu_claude.env`**，至少写入：

```bash
export ANTHROPIC_API_KEY="此处换成你的_Key"
# export ANTHROPIC_BASE_URL="https://…"   # 仅在使用网关时需要，见每日选题自动化.md
```

并执行 **`chmod 600 ~/.secrets/hongshu_claude.env`**。

**顺带说明**：网络采风 MCP、生图 API 等 **不是** 跑通「开始今天的工作」的必选项，以后再配即可。若按上表仍失败，再排查 Key 额度、网关地址或网络代理。

---

**可转发给协作者的「通关话术」（原样复制发送即可）**

> **两种情况先选一个：**  
> （1）**只用 Claude Code、网络能直连官方、终端里 `claude` 已经能用**：`cd` 到含 `CLAUDE.md` 的项目根，可运行 `sh ./routines/bootstrap_after_clone.sh`，然后 **`claude`**，说 **「开始今天的工作」** 即可，不必先做下面的 secrets。  
> （2）**国内/上不了官方、要用中转 API**：必须配置环境变量，按下面做。  
>   
> 若走（2）：「找不到 secrets」是正常的——Key 不在仓库里，避免误传到 GitHub。在家目录建保险箱：`mkdir -p ~/.secrets && chmod 700 ~/.secrets`；在 **能看到 `CLAUDE.md` 的项目根** 执行：  
> `cp .secrets/hongshu_claude.env.example ~/.secrets/hongshu_claude.env && chmod 600 ~/.secrets/hongshu_claude.env`  
> 编辑 **`~/.secrets/hongshu_claude.env`**：`export ANTHROPIC_API_KEY` + **`export ANTHROPIC_BASE_URL`**（URL 以你的服务商为准，示例见 **`routines/每日选题自动化.md`**）。  
> 终端先：`source ~/.secrets/hongshu_claude.env`，再 **`cd` 项目根**、**`claude`**，说 **「开始今天的工作」**。（只用 Cursor 聊天也可在 Cursor 里单独配 Key。）  
> 正常的话 **`日记/`** 里会出现 **当天日期** 文件夹和 **`选题建议.md`**。

---

## 运行期：路径错了、AI 说找不到文件夹？

### 仓库多一层「红书运营」时

若你 clone 后 **第一层目录里只有子文件夹「红书运营」**，没有直接看到 `CLAUDE.md`，请先 **`cd 红书运营`**：真正的 **项目根** = **含有 `CLAUDE.md` 的那一层**（与 `README.md` 同级）。Cursor 也要 **Open 这一层**，不要只打开外层的 `Soul_Nook` 空壳目录。

**一切路径相对于「项目根」**。在 Cursor 里请 **File → Open Folder** 只打开这一层。

### 找不到 `.secrets`？

- **名字以英文句号开头**，在 macOS **访达里默认隐藏**。请 **⌘⇧.**（显示隐藏文件），或在终端项目根执行 **`ls -la | grep secrets`**，应能看到 `.secrets/`。  
- 若在 **GitHub 网页** 找模板：进入仓库里与 `CLAUDE.md` 同级目录下的 **`.secrets`**，打开 **`hongshu_claude.env.example`**（[模板说明](../.secrets/README.md)）。  
- **真密钥不放仓库里**：按模板在本机建 **`~/.secrets/hongshu_claude.env`**（家目录，不是项目里的文件夹）。

### 初始化目录（bootstrap）

在项目根执行其一即可：

```bash
sh ./routines/bootstrap_after_clone.sh
```

或先赋予可执行权限再运行：

```bash
chmod +x ./routines/bootstrap_after_clone.sh
./routines/bootstrap_after_clone.sh
```

（若出现 `permission denied`，多半是直接 `./` 而文件未 `chmod +x`，改用上面的 **`sh ...`** 即可。）

- 当日内容：**`日记/YYYY-MM-DD/`**（由 Agent 或你手动建日期文件夹）
- 可选舵向：**`角落素材/YYYY-MM-DD-raw.md`**
- 生成图说明：**`assets/generated/`**（大文件通常不提交，见 `.gitignore`）

若仍报错，先核对：终端里 `pwd` 是否是含 `CLAUDE.md` 的目录；Agent 是否按 [`CLAUDE.md`](../CLAUDE.md) 使用相对路径 `日记/`、`角落素材/` 等。

---

## 三句就够的「第一天」

1. 打开 **含 `CLAUDE.md` 的项目根**（或终端 `cd` 到该目录）。  
2. **仅 B（网关）或跑定时脚本时**：配置 **`~/.secrets/hongshu_claude.env`**；**A（Claude Code 直连）且只交互用时** 可跳过。  
3. 在 **Cursor Chat** 或 **Claude Code** 里说：**「开始今天的工作」**（见 `CLAUDE.md` 触发语表）。

---

## 和另外几篇文档怎么配合？

| 文档 | 何时读 |
|------|--------|
| [**上手运行指南**](上手运行指南.md) | 需要逐步配环境、终端命令完整版 |
| [**GitHub上传与运行指南**](GitHub上传与运行指南.md) | 作者 push；别人 `git clone` 最短路径 |
| [**协作者从clone到第一句话**](协作者从clone到第一句话.md) | **本文**：三段式心理路径（你正在读的） |
