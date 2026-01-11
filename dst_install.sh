#!/bin/bash
set -e # 遇到错误立即停止

WORKDIR="/workspace"

# 定义内部路径 (对应 Docker 内部路径)
STEAMCMD="${WORKDIR}/steamcmd/steamcmd.sh"
DST_DIR="${WORKDIR}/dst_server"
KLEI_DIR="${WORKDIR}/.klei"

echo "========================================"
echo "🚀 [DST Installer] 开始安装/更新饥荒服务端..."
echo "========================================"

# 1. 调用 SteamCMD 下载/更新
# 343050 是饥荒联机版的 AppID
echo "⬇️  正在下载游戏文件 (约 1GB+，请耐心等待)..."
$STEAMCMD \
    +force_install_dir $DST_DIR \
    +login anonymous \
    +app_update 343050 \
    +quit

echo "✅ 游戏文件下载完成。"

echo "========================================"
echo "🎉 安装流程结束！"
echo "📂 游戏位置: $DST_DIR"
echo "📂 配置位置: $KLEI_DIR/DoNotStarveTogether"
echo "⚠️  提示: 请确保在主机的存档目录中放入 cluster_token.txt"
echo "========================================"

