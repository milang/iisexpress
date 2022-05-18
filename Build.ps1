#Requires -version 7

# GitHub Actions workflow commands:
# https://pakstech.com/blog/github-actions-workflow-commands/
# https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions

$ErrorActionPreference = "Stop"
$homeDir = Get-Location

# copy binaries
Write-Host "::group::Copy binaries"
$distDir = (New-Item -Force -ItemType Directory $homeDir/dist).FullName
Get-ChildItem $env:ProgramW6432/IIS*
Copy-Item -Recurse "$env:ProgramW6432/IIS Express" $distDir/x64
Get-ChildItem ${env:ProgramFiles(x86)}/IIS*
Copy-Item -Recurse "${env:ProgramFiles(x86)}/IIS Express" $distDir/x86
Write-Host "::endgroup::"

# package binaries
Write-Host "::group::Package binaries"
7z a -r -mx $homeDir/iisexpress.7z $distDir/*
Write-Host "::endgroup::"
