# 饥荒服务端公共配置文件
# 保存为: ~/dst_config.sh

# -------------------- 路径配置 --------------------
# 游戏二进制文件所在目录
# 既然你挂载了 dst_server 到 $HOME/dst_server，那么二进制就在 bin64 下
export DST_BIN="$HOME/dst_server/bin64"

# 你的存档文件夹名称 (位于 ~/.klei/DoNotStarveTogether/ 下)
export CLUSTER_NAME="MyDediServer"

# -------------------- 依赖环境 --------------------
# 确保系统能找到游戏目录下的动态链接库 (libcurl 等)
export LD_LIBRARY_PATH="$DST_BIN:$LD_LIBRARY_PATH"

