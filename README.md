# 歪比巴卜l 1Panel 第三方应用仓库

本仓库收录适用于 1Panel 的第三方本地应用安装包，支持 **1Panel 2.2.4 及以上版本**。

仓库并不专门服务于某一个项目。SublinkPro 是当前首个收录应用，后续应用会继续添加到 `apps/` 目录，并使用相同方式同步到 1Panel。

## 当前收录应用

| 应用 | 版本 | 说明 | 上游项目 |
| --- | --- | --- | --- |
| [SublinkPro](./apps/sublinkpro/README.md) | 1.2.18、latest | 代理订阅管理与转换平台 | [ZeroDeng01/sublinkPro](https://github.com/ZeroDeng01/sublinkPro) |

## 仓库结构

```text
.
├── apps/
│   ├── sublinkpro/       # 当前收录应用
│   │   ├── 1.2.18/
│   │   ├── latest/
│   │   ├── data.yml
│   │   ├── logo.png
│   │   ├── README.md
│   │   └── README_en.md
│   └── <其他应用>/       # 后续应用使用独立目录
├── .agents/skills/
│   └── 1panel-appstore-skills/  # 内置应用打包 Skill
├── data.yaml             # 仓库分类与版本元数据
└── README.md
```

每个 `apps/<应用标识>/` 都是一个可以独立复制到 1Panel 本地应用商店的完整安装包。

## 内置 1Panel 应用打包 Skill

仓库内置官方 [1Panel-appstore-skills](https://github.com/1Panel-dev/1Panel-appstore-skills)，位于 `.agents/skills/1panel-appstore-skills/`。Codex 从本仓库目录启动时会自动发现它，因此生成或校验应用包不需要依赖用户目录下的同名 Skill。

Skill 的完整说明见：

- [SKILL.md](./.agents/skills/1panel-appstore-skills/SKILL.md)：给 Codex 使用的打包规则和工作流程
- [README.zh-CN.md](./.agents/skills/1panel-appstore-skills/README.zh-CN.md)：中文使用说明
- `scripts/generate_app_package.py`：根据 app spec 生成应用包
- `scripts/validate_app_package.py`：校验应用包结构和配置

在仓库根目录运行内置校验脚本：

```bash
python3 .agents/skills/1panel-appstore-skills/scripts/validate_app_package.py apps/sublinkpro
```

生成新应用时，将 `assets/sample-appspec.json` 复制为自己的 spec，按 `references/appspec.md` 填写后运行：

```bash
python3 .agents/skills/1panel-appstore-skills/scripts/generate_app_package.py \
  --spec /path/to/appspec.json \
  --output apps
```

当前内置 Skill 来源于上游提交 `d1ff3daca7c9e3167bc61664a431a3ec6b77f587`。升级 Skill 时，请重新同步上游目录并记录新的提交号。

## 使用前准备

1. 确认 1Panel 版本不低于 `2.2.4`。
2. 确认服务器可以访问各应用使用的容器镜像仓库。
3. 确认服务器已安装 `git`，计划任务同步需要使用它。
4. 以下操作请使用 `root` 用户执行。若 1Panel 安装在其他目录，请将 `/opt/1panel` 替换为实际安装目录。

## 方法一：手动同步全部应用

下载或克隆本仓库，在仓库根目录执行：

```bash
mkdir -p /opt/1panel/resource/apps/local
cp -a apps/. /opt/1panel/resource/apps/local/
```

该命令会同步 `apps/` 下当前及以后收录的全部应用，但不会删除本地应用目录中的其他内容。

同步后的目录类似：

```text
/opt/1panel/resource/apps/local/
└── sublinkpro/
    ├── data.yml
    ├── 1.2.18/
    │   └── docker-compose.yml
    └── latest/
        └── docker-compose.yml
```

## 只同步一个应用

不需要整个仓库时，可以只复制指定应用。例如只同步 SublinkPro：

```bash
mkdir -p /opt/1panel/resource/apps/local/sublinkpro
cp -a apps/sublinkpro/. /opt/1panel/resource/apps/local/sublinkpro/
```

其他应用将 `sublinkpro` 替换为对应的 `apps/` 子目录名称即可。

## 方法二：通过计划任务自动同步

将本仓库发布到 GitHub 后，可以通过 1Panel 计划任务定期同步当前及以后收录的全部应用。

在 1Panel 的“计划任务”中新建 Shell 任务，将下面的 `REPO_URL` 改为本仓库地址：

```bash
#!/bin/sh
set -eu

REPO_URL="https://github.com/<owner>/<repository>.git"
TARGET_DIR="/opt/1panel/resource/apps/local"
TMP_DIR="$(mktemp -d)"

trap 'rm -rf "$TMP_DIR"' EXIT INT TERM

git clone --depth=1 "$REPO_URL" "$TMP_DIR/repository"
mkdir -p "$TARGET_DIR"
cp -a "$TMP_DIR/repository/apps/." "$TARGET_DIR/"

echo "第三方应用仓库同步完成"
```

建议每天执行一次。脚本只添加或覆盖本仓库同名应用的安装包，不会清空整个 1Panel 本地应用目录。

## 在 1Panel 中安装应用

完成手动或自动同步后：

1. 打开 1Panel 的“应用商店”。
2. 进入“本地”应用页面。
3. 点击“更新应用列表”或“同步”。
4. 搜索需要的应用。
5. 选择版本、填写安装参数并安装。

同步仓库只会更新本地应用商店中的安装包，不会自动升级或重建已经运行的应用。

## 更新仓库中的应用

1. 重新执行手动同步命令，或者等待计划任务完成。
2. 在 1Panel 应用商店中更新本地应用列表。
3. 进入“已安装”应用页面，根据应用提供的版本执行升级。

使用 `latest` 镜像的应用不会因为仓库同步而自动拉取新镜像。需要在 1Panel 中执行相应应用的升级或重建操作，操作前请先备份数据。

## 应用文档

各应用的功能、安装参数、访问方式、数据目录和注意事项可能不同。请从“当前收录应用”列表进入对应应用的 README，并在安装时查看 1Panel 展示的参数说明。

升级、迁移或卸载任何应用前，请先停止应用，并备份其实际安装目录中的持久化数据。`/opt/1panel/resource/apps/local` 存放的是应用商店安装包，不是运行实例的数据目录。

## 常见问题

### 本地应用列表中没有仓库应用

- 确认 1Panel 版本不低于 `2.2.4`。
- 确认应用目录位于 `/opt/1panel/resource/apps/local/<应用标识>`。
- 确认应用目录下直接存在 `data.yml`，没有多嵌套一层 `apps/`。
- 回到应用商店手动更新本地应用列表。

### 应用容器无法启动

- 检查安装端口是否已被占用。
- 检查服务器能否拉取该应用使用的容器镜像。
- 检查 Docker 中是否存在 1Panel 创建的 `1panel-network` 网络。
- 在 1Panel 的应用日志中查看具体错误。

### 仓库同步后，已安装应用没有变化

这是正常现象。仓库同步更新的是本地应用安装包；运行中的应用需要在 1Panel 中单独执行升级或重建。

## 相关链接

- 1Panel：<https://github.com/1Panel-dev/1Panel>

## 声明

本仓库是第三方 1Panel 应用仓库，不隶属于 1Panel 或所收录应用的上游项目。各应用的镜像、功能、安全性、许可证和更新策略以上游项目为准。
