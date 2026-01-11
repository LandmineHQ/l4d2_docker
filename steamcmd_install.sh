#!/usr/bin/env bash
set -euo pipefail

WORKDIR="/workspace"
TARBALL="${WORKDIR}/steamcmd_linux.tar.gz"
INSTALL_DIR="${WORKDIR}/steamcmd"

cd "${WORKDIR}"

if [[ ! -f "${TARBALL}" ]]; then
  echo "ERROR: 找不到 ${TARBALL}"
  echo "请确认 steamcmd_linux.tar.gz 已放在容器内 ${WORKDIR}（宿主机挂载目录）"
  exit 1
fi

mkdir -p "${INSTALL_DIR}"

# 如果目录非空，给出提示（不强制覆盖）
if [[ -n "$(ls -A "${INSTALL_DIR}" 2>/dev/null || true)" ]]; then
  echo "WARN: ${INSTALL_DIR} 非空，将在其上解压（可能覆盖同名文件）"
  echo "      如需全新安装，可先清空：rm -rf ${INSTALL_DIR:?}/*"
fi

echo "[1/3] 解压 SteamCMD 到 ${INSTALL_DIR}"
tar -xzf "${TARBALL}" -C "${INSTALL_DIR}"

chmod +x "${INSTALL_DIR}/steamcmd.sh"

echo "[2/3] 匿名登录一次以完成初始化/自更新"
"${INSTALL_DIR}/steamcmd.sh" +login anonymous +quit

echo "[3/3] 验证"
test -x "${INSTALL_DIR}/steamcmd.sh"

echo "OK: steamcmd 安装完成：${INSTALL_DIR}"
echo "提示：后续使用 ${INSTALL_DIR}/steamcmd.sh ..."
