[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$VaultPath)

$ErrorActionPreference = 'Stop'
$VaultPath = [IO.Path]::GetFullPath($VaultPath)
$checks = [ordered]@{}
foreach ($relative in @(
    '01-收件箱','10-主题','20-项目','30-资源','40-长期记忆','90-归档','_系统','_模板','_数据库','.obsidian',
    '_模板\知识条目模板.md','_模板\项目模板.md','_数据库\知识总库.base','_数据库\项目.base',
    '.obsidian\core-plugins.json','.obsidian\templates.json'
)) {
    $checks[$relative] = Test-Path -LiteralPath (Join-Path $VaultPath $relative)
}
$core = Get-Content -LiteralPath (Join-Path $VaultPath '.obsidian\core-plugins.json') -Raw -Encoding UTF8 | ConvertFrom-Json
foreach ($required in @('bases','properties','templates','daily-notes','file-recovery')) {
    $checks["core:$required"] = $core -contains $required
}
$templates = Get-Content -LiteralPath (Join-Path $VaultPath '.obsidian\templates.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$checks['templateFolder'] = $templates.folder -eq '_模板'
$checks['noApiRequired'] = $true
$ok = @($checks.GetEnumerator() | Where-Object { $_.Value -ne $true }).Count -eq 0
[ordered]@{ ok = $ok; checks = $checks } | ConvertTo-Json -Depth 6
if (-not $ok) { exit 2 }
