# Left 4 Dead 2 专用服务器 Docker 脚本

本项目提供一套基于 SteamCMD 的 **Left 4 Dead 2（L4D2）** 专用服务器 Docker 安装与更新脚本。

说明：为了兼容现有流程，脚本文件名仍保留 `dst_*`，但内容已经全部切换为 L4D2。

## 文件说明

- `Dockerfile`：基于 Ubuntu 24.04，安装 L4D2 服务端需要的 32 位运行库。
- `docker_build.sh`：构建镜像（默认标签 `steamcmd-l4d2:0.0.1`）。
- `steamcmd_download.sh`：在宿主机下载 `steamcmd_linux.tar.gz`。
- `steamcmd_install.sh`：在容器内安装 SteamCMD 到 `/workspace/steamcmd`。
- `dst_config.sh`：L4D2 运行参数默认值（端口、地图、模式、GSLT 等）。
- `dst_install.sh`：安装或更新 L4D2 专用服务器（`AppID 222860`）。
- `dst_start.sh`：通过 `srcds_run` 启动 L4D2 服务端。

## 快速开始

1. 在宿主机下载 SteamCMD 压缩包：

```bash
bash steamcmd_download.sh
```

2. 构建镜像：

```bash
bash docker_build.sh
```

3. 启动容器并挂载持久化目录：

```bash
docker run -it --rm \
  --name l4d2-server \
  -v /opt/l4d2:/workspace \
  -p 27015:27015/udp \
  -p 27015:27015/tcp \
  -p 27005:27005/udp \
  -p 27020:27020/udp \
  steamcmd-l4d2:0.0.1 bash
```

4. 在容器内依次执行：

```bash
bash steamcmd_install.sh
bash dst_install.sh
bash dst_start.sh
```

## 更新服务器

在容器内重新执行安装脚本即可更新：

```bash
bash dst_install.sh
```

如需完整校验文件：

```bash
L4D2_VALIDATE=1 bash dst_install.sh
```

## 运行参数说明

默认参数在 `dst_config.sh` 中定义，也可以通过环境变量覆盖。

常用参数：

- `L4D2_APP_ID`：默认 `222860`
- `L4D2_BRANCH`：默认 `public`
- `L4D2_VALIDATE`：`0` 或 `1`
- `SERVER_NAME`：服务器名称
- `MAP`：启动地图，默认 `c1m1_hotel`
- `GAME_MODE`：游戏模式，默认 `coop`
- `MAX_PLAYERS`：最大玩家数，默认 `4`
- `HOST_PORT`：主服务端口，默认 `27015`
- `CLIENT_PORT`：客户端端口，默认 `27005`
- `TV_PORT`：SourceTV 端口，默认 `27020`
- `GSLT`：Steam 游戏服务器登录令牌（可选）
- `EXTRA_ARGS`：附加 `srcds_run` 参数（可选）

示例：

```bash
SERVER_NAME="My L4D2 Server" \
MAP="c5m1_waterfront" \
GAME_MODE="versus" \
MAX_PLAYERS=8 \
GSLT="YOUR_TOKEN" \
bash dst_start.sh
```

## 注意事项

- 请确保 `/workspace` 做了卷挂载，避免容器重建后数据丢失。
- 游戏文件默认位于 `/workspace/l4d2_server`。
- 常用服务端配置文件路径：
  `/workspace/l4d2_server/left4dead2/cfg/server.cfg`
- 请确保宿主机挂载目录对容器内 `steam` 用户有读写权限。