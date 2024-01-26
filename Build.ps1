#!/usr/bin/env pwsh
#spell-checker:words
#Requires -Version 7

# GitHub Actions workflow commands:
# https://pakstech.com/blog/github-actions-workflow-commands/
# https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Copy binaries.
Write-Host "::group::Copy binaries"
$workDir = Get-Location
$distDir = New-Item -ItemType Directory $workDir/dist
Get-ChildItem $env:ProgramW6432/IIS* # Keeping this to see what IIS directories are available in the runner in x64 program files directory.
Copy-Item -Recurse "$env:ProgramW6432/IIS Express" $distDir/x64
Get-ChildItem ${env:ProgramFiles(x86)}/IIS* # Keeping this to see what IIS directories are available in the runner in x86 program files directory.
Copy-Item -Recurse "${env:ProgramFiles(x86)}/IIS Express" $distDir/x86
Write-Host "::endgroup::"

# Package binaries.
Write-Host "::group::Package binaries"
7z a -r -mx $workDir/iisexpress.7z $distDir/*
Write-Host "::endgroup::"
