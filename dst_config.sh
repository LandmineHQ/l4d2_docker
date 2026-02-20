#!/usr/bin/env bash

# -------------------- 基础路径 --------------------
export WORKDIR="${WORKDIR:-/workspace}"
export STEAMCMD="${STEAMCMD:-${WORKDIR}/steamcmd/steamcmd.sh}"
export L4D2_DIR="${L4D2_DIR:-${WORKDIR}/l4d2_server}"

# -------------------- 安装/更新参数 --------------------
export L4D2_APP_ID="${L4D2_APP_ID:-222840}"
export L4D2_BRANCH="${L4D2_BRANCH:-public}"
export L4D2_VALIDATE="${L4D2_VALIDATE:-0}"

# -------------------- 服务器启动参数 --------------------
export SERVER_NAME="${SERVER_NAME:-L4D2 Docker Server}"
export MAP="${MAP:-c1m1_hotel}"
export GAME_MODE="${GAME_MODE:-coop}"
export MAX_PLAYERS="${MAX_PLAYERS:-4}"

# -------------------- 网络端口 --------------------
export HOST_PORT="${HOST_PORT:-27015}"
export CLIENT_PORT="${CLIENT_PORT:-27005}"
export TV_PORT="${TV_PORT:-27020}"

# -------------------- 其他可选项 --------------------
export SV_LAN="${SV_LAN:-0}"
export REGION="${REGION:-255}"
export SERVER_CFG="${SERVER_CFG:-server.cfg}"
export GSLT="${GSLT:-}"
export EXTRA_ARGS="${EXTRA_ARGS:-}"