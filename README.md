# Obsidian 本地知识库自动配置

`obsidian-vault-setup` 是一个面向 Codex 的本地 Skill，用来建立或补齐 Obsidian Vault 的目录骨架、核心插件配置、笔记模板与 Bases 数据库视图。

当前版本：`v1.0.0`

## 特点

- 不需要 Obsidian API、Copilot、第三方模型或云数据库。
- 默认只创建缺失内容，不覆盖已有笔记。
- 使用 Markdown 和属性作为事实源，`.base` 只负责本地数据库视图。
- Windows 提供一键脚本；macOS 可由 Codex 按同一模板非破坏性配置。
- 自带验收脚本与人工验收清单。

## 安装为 Codex Skill

将仓库克隆或下载后，把整个目录复制到 Codex 的 Skills 目录，并保持 `SKILL.md` 位于 Skill 根目录。

也可以下载 Releases 中的 ZIP，解压后安装 `obsidian-vault-setup` 文件夹。

## Windows 一键配置

双击：

```text
开始配置黑曜石.cmd
```

然后粘贴 Obsidian Vault 的完整路径。也可直接运行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/setup-obsidian-vault.ps1 -VaultPath "D:\你的知识库"
```

## macOS

本仓库不包含依赖 Windows 的二进制。让 Codex 读取 `SKILL.md`、`assets/vault-template` 与 `references/acceptance.md`，在目标 Vault 中创建相同结构即可；不得覆盖已有文件。

## 验收边界

脚本通过表示目录、模板、两个 `.base` 文件和核心插件配置已完成静态验收。接收方仍需在 Obsidian 中打开 `_数据库/知识总库.base`，完成一次界面确认。

## 隐私与安全

- 仓库不包含 API 密钥、Copilot 配置、云数据库配置或个人笔记。
- 不读取 `.obsidian/plugins/*/data.json`。
- 不修改 `workspace.json`，不安装社区插件。

## 许可证

[MIT](LICENSE)
