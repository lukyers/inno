Invoke-Expression .\logo.ps1

$x = $MyInvocation.MyCommand.Definition
$x = Split-Path $MyInvocation.MyCommand.Definition

Write-Host $x

Write-Host 'Press Any Key!' -NoNewline
$null = [Console]::ReadKey('?')