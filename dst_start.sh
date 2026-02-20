#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/dst_config.sh"

if [[ ! -x "${L4D2_DIR}/srcds_run" ]]; then
  echo "错误：未找到 ${L4D2_DIR}/srcds_run"
  echo "请先执行 dst_install.sh"
  exit 1
fi

cd "${L4D2_DIR}"

cmd=(
  ./srcds_run
  -game left4dead2
  -console
  -usercon
  -port "${HOST_PORT}"
  +clientport "${CLIENT_PORT}"
  +tv_port "${TV_PORT}"
  +hostname "${SERVER_NAME}"
  +map "${MAP}"
  +sv_gametypes "${GAME_MODE}"
  +maxplayers "${MAX_PLAYERS}"
  +sv_lan "${SV_LAN}"
  +sv_region "${REGION}"
  +servercfgfile "${SERVER_CFG}"
)

if [[ -n "${GSLT}" ]]; then
  cmd+=(+sv_setsteamaccount "${GSLT}")
fi

if [[ -n "${EXTRA_ARGS}" ]]; then
  # 支持通过 EXTRA_ARGS 追加自定义引擎参数。
  # shellcheck disable=SC2206
  extra=( ${EXTRA_ARGS} )
  cmd+=("${extra[@]}")
fi

echo "========================================"
echo "[L4D2 服务端] 正在启动"
echo "目录: ${L4D2_DIR}"
echo "地图: ${MAP}"
echo "模式: ${GAME_MODE}"
echo "端口: ${HOST_PORT}"
echo "========================================"

exec "${cmd[@]}"