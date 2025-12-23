# Don't Starve Together 专用服务器 Docker 镜像

## 简介

本项目提供了一个基于 `steamcmd` 的 **Don't Starve Together (DST)** 专用服务器 Docker 镜像的构建配置。它旨在提供一个干净、可重复的环境，特别优化了与 **MCSM (Minecraft Server Manager)** 等面板的集成，确保游戏文件和配置数据的持久化。

## 核心文件说明

| 文件名 | 作用 | 详细说明 |
| :--- | :--- | :--- |
| `Dockerfile` | 镜像构建文件 | 基于 Debian 系统，安装必要的 32 位和 64 位依赖，创建名为 `steam` 的非特权用户（UID/GID 默认为 1001），并安装 SteamCMD。 |
| `install_dst.sh` | 游戏安装脚本 | 使用 SteamCMD 匿名登录并下载/更新 DST 专用服务器文件（AppID: 343050）到容器内的 `/home/steam/dst_server` 目录。 |
| `dst_config.sh` | 环境变量配置 | 定义了游戏二进制文件路径 (`DST_BIN`) 和集群名称 (`CLUSTER_NAME`) 等关键环境变量。 |
| `start_master.sh` | 启动主世界 | 启动 DST 专用服务器的主世界（Master Shard）。 |
| `start_caves.sh` | 启动洞穴世界 | 启动 DST 专用服务器的洞穴世界（Caves Shard）。 |

## 脚本功能详解

### `install_dst.sh`

该脚本是首次运行或更新游戏时使用的核心脚本。

1.  **功能**: 调用 SteamCMD，使用 `+app_update 343050` 命令下载或更新 DST 专用服务器文件。
2.  **安装路径**: 游戏文件会被安装到容器内的 `/home/steam/dst_server` 目录。
3.  **配置提示**: 脚本提示用户需要将 `cluster_token.txt` 放置在配置目录中，以确保服务器能够正常运行。

## MCSM Docker 配置与数据持久化

为了确保游戏数据、存档和配置在容器重启后不会丢失，您需要在 MCSM 或其他 Docker 管理工具中配置卷（Volume）挂载。

以下是必须进行持久化挂载的容器内部目录：

| 容器内部路径 | 宿主机挂载路径 (示例) | 作用 |
| :--- | :--- | :--- |
| `/home/steam/dst_server` | `/path/to/dst_server` | **游戏文件目录**。包含游戏二进制文件和 SteamCMD 下载的所有内容。 |
| `/home/steam/.klei` | `/path/to/klei_config` | **服务器配置和存档目录**。包含 `DoNotStarveTogether` 文件夹，其中存放了 `cluster.ini`、存档文件、Mod 配置等。 |

### ⚠️ 权限设置重要提醒 ⚠️

`Dockerfile` 中创建了名为 `steam` 的非特权用户来运行服务器，以提高安全性。该用户在容器内部的 **UID (用户ID)** 和 **GID (用户组ID)** 默认为 **`1001:1001`**。

**问题**: 如果宿主机上挂载的目录（例如 `/path/to/dst_server` 和 `/path/to/klei_config`）的所有者不是 `1001:1001`，容器内的 `steam` 用户将没有权限读写这些目录，导致服务器启动失败或无法保存存档。

**解决方案**: 在启动容器之前，您必须在宿主机上将挂载目录的所有权更改为 `1001:1001`。

```bash
# 假设您的挂载目录是 /opt/dst_data/dst_server 和 /opt/dst_data/.klei
sudo chown -R 1001:1001 /opt/dst_data/dst_server
sudo chown -R 1001:1001 /opt/dst_data/.klei
```

请务必执行此步骤，否则容器将无法正常运行。
