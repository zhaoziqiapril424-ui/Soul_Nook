#!/bin/sh
# clone 后在「项目根」（与 CLAUDE.md 同级）执行，确保常用目录存在。
# 请用：sh ./routines/bootstrap_after_clone.sh
# 或：chmod +x ./routines/bootstrap_after_clone.sh && ./routines/bootstrap_after_clone.sh
# 勿依赖 bash：便于 macOS 默认 sh 直接运行。
set -eu
ROOT="$(CDPATH= cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
if [ ! -f CLAUDE.md ]; then
  echo "错误：请在仓库根目录执行（这一层须有 CLAUDE.md）。当前: $ROOT" >&2
  exit 1
fi
mkdir -p \
  日记 \
  角落素材 \
  数据输入 \
  内容库/published \
  品牌资产/logos \
  assets/generated
echo "OK：目录已就绪。项目根 = $ROOT （此后口令与路径均相对这里）"
