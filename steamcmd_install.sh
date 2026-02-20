#!/usr/bin/env bash
set -euo pipefail

WORKDIR="${WORKDIR:-/workspace}"
TARBALL="${WORKDIR}/steamcmd_linux.tar.gz"
INSTALL_DIR="${WORKDIR}/steamcmd"

cd "${WORKDIR}"

if [[ ! -f "${TARBALL}" ]]; then
  echo "错误：未找到 ${TARBALL}"
  echo "请先把 steamcmd_linux.tar.gz 放到 ${WORKDIR}"
  exit 1
fi

mkdir -p "${INSTALL_DIR}"

if [[ -n "$(ls -A "${INSTALL_DIR}" 2>/dev/null || true)" ]]; then
  echo "警告：${INSTALL_DIR} 非空"
  echo "将复用该目录；如需全新安装请先手动清空。"
fi

echo "[1/3] 解压 SteamCMD 到 ${INSTALL_DIR}"
tar -xzf "${TARBALL}" -C "${INSTALL_DIR}"

chmod +x "${INSTALL_DIR}/steamcmd.sh"

echo "[2/3] 执行一次匿名登录进行初始化"
"${INSTALL_DIR}/steamcmd.sh" +login anonymous +quit

echo "[3/3] 校验安装结果"
test -x "${INSTALL_DIR}/steamcmd.sh"

echo "完成：SteamCMD 已就绪，目录 ${INSTALL_DIR}"