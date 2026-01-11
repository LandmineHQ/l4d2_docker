#!/bin/bash
# 保存为: ~/start_caves.sh

source dst_config.sh

# 1. 进入游戏二进制目录
cd "$DST_BIN" || { echo "❌ 错误: 找不到目录 $DST_BIN"; exit 1; }

echo "🚀 [洞穴世界] 正在启动..."
echo "   程序位置: $(pwd)"
echo "   存档名称: $CLUSTER_NAME"

# 2. 启动游戏
exec ./dontstarve_dedicated_server_nullrenderer_x64 \
    -console \
    -cluster "$CLUSTER_NAME" \
    -shard "Caves"

