[CmdletBinding()]
param(
    [string]$VaultPath,
    [switch]$ForceTemplates
)

$ErrorActionPreference = 'Stop'
if ([string]::IsNullOrWhiteSpace($VaultPath)) {
    $VaultPath = Read-Host '请粘贴 Obsidian Vault 的完整路径'
}
$VaultPath = [IO.Path]::GetFullPath($VaultPath.Trim().Trim('"'))
New-Item -ItemType Directory -Path $VaultPath -Force | Out-Null

$skillRoot = Split-Path $PSScriptRoot -Parent
$templateRoot = Join-Path $skillRoot 'assets\vault-template'
$folders = @('01-收件箱','10-主题','20-项目','30-资源','40-长期记忆','90-归档','_系统','_模板','_数据库','.obsidian')
foreach ($folder in $folders) {
    New-Item -ItemType Directory -Path (Join-Path $VaultPath $folder) -Force | Out-Null
}

$created = [Collections.Generic.List[string]]::new()
$preserved = [Collections.Generic.List[string]]::new()
Get-ChildItem -LiteralPath $templateRoot -Recurse -File | ForEach-Object {
    $relative = $_.FullName.Substring($templateRoot.Length + 1)
    $target = Join-Path $VaultPath $relative
    New-Item -ItemType Directory -Path (Split-Path $target -Parent) -Force | Out-Null
    if (Test-Path -LiteralPath $target) {
        if ($ForceTemplates) {
            $backup = "$target.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
            Copy-Item -LiteralPath $target -Destination $backup
            Copy-Item -LiteralPath $_.FullName -Destination $target -Force
            $created.Add("$relative (updated-with-backup)")
        } else {
            $preserved.Add($relative)
        }
    } else {
        Copy-Item -LiteralPath $_.FullName -Destination $target
        $created.Add($relative)
    }
}

$corePath = Join-Path $VaultPath '.obsidian\core-plugins.json'
$core = [Collections.Generic.List[string]]::new()
if (Test-Path -LiteralPath $corePath) {
    $existing = Get-Content -LiteralPath $corePath -Raw -Encoding UTF8 | ConvertFrom-Json
    foreach ($item in $existing) { if ($item -is [string] -and -not $core.Contains($item)) { $core.Add($item) } }
}
foreach ($required in @('bases','properties','templates','daily-notes','file-recovery')) {
    if (-not $core.Contains($required)) { $core.Add($required) }
}
[IO.File]::WriteAllText($corePath, (($core | ConvertTo-Json) + [Environment]::NewLine), [Text.UTF8Encoding]::new($false))

$templatesPath = Join-Path $VaultPath '.obsidian\templates.json'
if (-not (Test-Path -LiteralPath $templatesPath)) {
    $templateConfig = [ordered]@{ folder = '_模板' } | ConvertTo-Json
    [IO.File]::WriteAllText($templatesPath, ($templateConfig + [Environment]::NewLine), [Text.UTF8Encoding]::new($false))
}

$verification = & (Join-Path $PSScriptRoot 'verify-obsidian-vault.ps1') -VaultPath $VaultPath | ConvertFrom-Json
[ordered]@{
    ok = $verification.ok
    vault = $VaultPath
    created = $created
    preserved = $preserved
    verification = $verification
    next = '在 Obsidian 中打开该文件夹，并打开 _数据库/知识总库.base 完成界面验收。'
} | ConvertTo-Json -Depth 8
if (-not $verification.ok) { exit 2 }
