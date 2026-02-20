#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/dst_config.sh"

if [[ ! -x "${STEAMCMD}" ]]; then
  echo "错误：未找到 SteamCMD：${STEAMCMD}"
  echo "请先执行 steamcmd_install.sh"
  exit 1
fi

mkdir -p "${L4D2_DIR}"

echo "========================================"
echo "[L4D2 安装器] 开始安装或更新 (绕过 Valve Bug)"
echo "SteamCMD: ${STEAMCMD}"
echo "目标目录: ${L4D2_DIR}"
echo "========================================"

# 组装基础的 app_update 参数
app_update_cmd=(+app_update "${L4D2_APP_ID}")

if [[ "${L4D2_BRANCH}" != "public" ]]; then
  app_update_cmd+=(-beta "${L4D2_BRANCH}")
fi

if [[ "${L4D2_VALIDATE}" == "1" ]]; then
  app_update_cmd+=(validate)
fi

echo "-> [阶段 1/2] 正在拉取 Windows 基础文件 (绕过权限限制)..."
"${STEAMCMD}" \
  +@sSteamCmdForcePlatformType windows \
  +force_install_dir "${L4D2_DIR}" \
  +login anonymous \
  "${app_update_cmd[@]}" \
  +quit

echo "-> [阶段 2/2] 正在拉取 Linux 专属执行文件..."
"${STEAMCMD}" \
  +@sSteamCmdForcePlatformType linux \
  +force_install_dir "${L4D2_DIR}" \
  +login anonymous \
  "${app_update_cmd[@]}" \
  +quit

echo "========================================"
echo "L4D2 服务端文件已就绪！"
echo "路径: ${L4D2_DIR}"
echo "========================================"