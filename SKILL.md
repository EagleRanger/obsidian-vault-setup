---
name: obsidian-vault-setup
description: 在 Windows 或 macOS 的本地文件夹中自动建立或补齐 Obsidian 知识库骨架、核心插件配置、模板与 Bases 数据库视图，并进行非破坏性验收。用于“配置黑曜石数据库”“Obsidian Bases”“建立本地知识库”“迁移 Vault”“一键初始化 Obsidian”或降低新手配置成本。默认不配置 Copilot、API、云数据库或任何密钥，不覆盖已有笔记。
---

# Obsidian 本地知识库自动配置

## 原则

- Markdown 文件和属性是事实源，`.base` 只保存本地数据库视图。
- 不要求 Obsidian API、Copilot、第三方模型或云数据库。
- 默认只创建缺失内容；已有笔记、插件列表和设置必须保留。
- 配置前先读取 `references/setup-guide.md`，了解用户需要提供的唯一必填项：Vault 路径。

## 执行

### Windows

在 Skill 根目录运行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/setup-obsidian-vault.ps1 -VaultPath "D:\你的知识库"
```

也可以双击 `开始配置黑曜石.cmd`，按提示粘贴路径。

### macOS

本包不包含依赖 Windows 的二进制。Codex 可直接读取 `assets/vault-template` 和本 Skill 的约束，在目标 Vault 中创建相同目录与文件；不得覆盖已有文件。完成后按 `references/acceptance.md` 人工验收。

## 验收

Windows 配置脚本会调用 `scripts/verify-obsidian-vault.ps1`。只有目录、模板、两个 `.base` 文件、核心插件 JSON 和保留性检查都通过，才能报告完成。界面是否能打开 Bases 仍需接收方在 Obsidian 中做一次可视确认。

## 禁止

- 不读取或复制 `.obsidian/plugins/*/data.json` 中的令牌、密钥和服务地址。
- 不安装社区插件，不修改 `workspace.json`，不操作 Obsidian 内部 API。
- 不把“文件已创建”写成“Obsidian 界面已验收”。
