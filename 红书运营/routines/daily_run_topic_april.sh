#!/usr/bin/env bash
# 每日只跑「选题 April」：生成 日记/YYYY-MM-DD/选题建议.md（不跑文案/设计/发布）
# 用法：手动本机试跑 → 再挂 launchd（见 每日选题自动化.md）
set -euo pipefail

export TZ="${TZ:-Asia/Shanghai}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

# launchd 非登录 shell 不会读 .zshrc；把智谱/Anthropic 变量放在此文件（chmod 600，勿提交 Git）
# 示例行：export ANTHROPIC_BASE_URL="https://open.bigmodel.cn/api/anthropic"
#         export ANTHROPIC_API_KEY="..."
if [[ -f "${HOME}/.secrets/hongshu_claude.env" ]]; then
  set -a
  # shellcheck source=/dev/null
  source "${HOME}/.secrets/hongshu_claude.env"
  set +a
fi

if ! command -v claude &>/dev/null; then
  echo "claude: 未找到。请把 Homebrew 的 bin 加入 PATH（如 /opt/homebrew/bin）" >&2
  exit 1
fi
if ! command -v python3 &>/dev/null; then
  echo "需要 python3 以把 agents.json 压成一行传给 --agents" >&2
  exit 1
fi

if [[ -z "${ANTHROPIC_API_KEY:-}" ]]; then
  echo "未设置 ANTHROPIC_API_KEY。请在 ~/.zshrc 或 ~/.secrets/hongshu_claude.env 中配置。" >&2
  exit 1
fi

AGENTS_FILE="${ROOT}/routines/agents.json"
if [[ ! -f "$AGENTS_FILE" ]]; then
  echo "缺少: $AGENTS_FILE" >&2
  exit 1
fi
AGENTS_ONELINE="$(AGENTS_FILE="$AGENTS_FILE" python3 -c "import os,json; p=os.environ['AGENTS_FILE']; print(json.dumps(json.load(open(p))))")" || exit 1

TODAY="$(date +%Y-%m-%d)"
LOG_DIR="${ROOT}/routines/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="${LOG_DIR}/daily-topic-${TODAY}.log"
{
  echo "===== $(date) ====="
} >>"$LOG_FILE"

# 与 ccxh 一致用 --bare；--add-dir 让模型能读仓库内 aboutme/CLAUDE 等
# 无人在场时须能写 日记/…；本机可信任时可用 --permission-mode 或下面对危险项二选一
PM="${HONGSHU_CLAUDE_PERMISSION_MODE:-bypassPermissions}"

PROMPT="今日以北京时间计，当天日期是 ${TODAY}。在仓库根目录下，你以子 Agent「topic-april」身份工作。本任务**仅**做选题阶段：确保存在「日记/${TODAY}/」并写入「选题建议.md」（3 套方案），遵守 aboutme 与 网络采风规则、白名单；MCP 仅在白名单内。不要写 文案初稿.md、不要写 设计稿、不要发小红书。用 Read 读取 aboutme.md、routines/网络采风规则.md、routines/网络采风白名单.md，以及 角落素材/${TODAY}-raw.md（若不存在则当无额外舵向）。"

set +e
claude --bare -p \
  --add-dir "$ROOT" \
  --agents "$AGENTS_ONELINE" \
  --agent topic-april \
  --permission-mode "$PM" \
  "$PROMPT" >>"$LOG_FILE" 2>&1
EC=$?
set -e
{
  echo "===== 结束: exit $EC  $(date) ====="
} >>"$LOG_FILE"
exit "$EC"
