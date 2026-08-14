# 接收方配置引导

## 准备

1. 从 [Obsidian 官网](https://obsidian.md/download) 安装桌面版。
2. 决定一个本地文件夹作为 Vault。已有 Vault 也可以；脚本默认不覆盖。
3. Windows 双击根目录的 `开始配置黑曜石.cmd`，粘贴 Vault 完整路径。

## 自动完成的内容

- 建立收件箱、主题、项目、资源、长期记忆、归档、系统、模板和数据库目录；
- 启用 Obsidian 核心插件 Bases、Properties、Templates、Daily notes 和 File recovery；
- 建立知识条目与项目模板；
- 建立知识总库和项目两个 `.base` 视图；
- 生成本地欢迎页和使用约定；
- 验证 JSON 可读、关键文件齐全和旧文件未被覆盖。

Obsidian 官方说明：Bases 是核心插件，数据仍保存在本地 Markdown 文件及其属性中，视图配置保存在 `.base` 文件中：[Obsidian Bases](https://obsidian.md/help/bases)。

## 不会做的内容

- 不配置 Obsidian API；
- 不安装或配置 Copilot；
- 不需要 MySQL、PostgreSQL 或云数据库；
- 不读取你的正文，不上传文件；
- 不修改现有社区插件和界面布局。

## 人工确认

配置完成后，在 Obsidian 中把该文件夹作为 Vault 打开，再打开 `_数据库/知识总库.base`。能看到表格视图并能根据属性显示笔记，才算界面层验收完成。
