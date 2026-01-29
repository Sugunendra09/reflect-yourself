# reflect-yourself installer for Cursor (Windows PowerShell)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "reflect-yourself installer" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan
Write-Host ""

$CursorDir = "$env:USERPROFILE\.cursor"

Write-Host "Where would you like to install?"
Write-Host ""
Write-Host "1) Personal skill ($CursorDir\skills\reflect-yourself\)"
Write-Host "   - Available in ALL your projects"
Write-Host ""
Write-Host "2) Current project (.cursor\)"
Write-Host "   - Only for this project, can be committed to git"
Write-Host ""

$choice = Read-Host "Choose [1/2]"

switch ($choice) {
    "1" {
        $Dest = "$CursorDir\skills\reflect-yourself"
        
        New-Item -ItemType Directory -Force -Path "$Dest\commands" | Out-Null
        New-Item -ItemType Directory -Force -Path "$Dest\rules" | Out-Null
        
        Copy-Item "$ScriptDir\SKILL.md" "$Dest\" -Force
        Copy-Item "$ScriptDir\commands\*" "$Dest\commands\" -Force
        Copy-Item "$ScriptDir\rules\*" "$Dest\rules\" -Force
        Copy-Item "$ScriptDir\reflect-queue.json" "$Dest\" -Force
        
        Write-Host ""
        Write-Host "Installed to $Dest" -ForegroundColor Green
        Write-Host ""
        Write-Host "The skill is now available in all your Cursor projects."
    }
    "2" {
        if (-not (Test-Path ".cursor")) {
            New-Item -ItemType Directory -Path ".cursor" | Out-Null
        }
        
        New-Item -ItemType Directory -Force -Path ".cursor\commands" | Out-Null
        New-Item -ItemType Directory -Force -Path ".cursor\rules" | Out-Null
        
        Copy-Item "$ScriptDir\commands\*" ".cursor\commands\" -Force
        Copy-Item "$ScriptDir\rules\*" ".cursor\rules\" -Force
        Copy-Item "$ScriptDir\reflect-queue.json" ".cursor\" -Force
        
        Write-Host ""
        Write-Host "Installed to .cursor\" -ForegroundColor Green
        Write-Host ""
        Write-Host "Commands and rules are now available in this project."
        Write-Host ""
        Write-Host "Consider adding to .gitignore:"
        Write-Host "  .cursor/reflect-queue.json"
    }
    default {
        Write-Host "Invalid choice. Exiting." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "Usage:" -ForegroundColor Yellow
Write-Host "  /reflect-yourself        - Capture learnings from session"
Write-Host "  /reflect-yourself-skills - Discover skill patterns"
Write-Host "  /reflect-yourself-queue  - View pending learnings"
Write-Host "  /reflect-yourself-skip   - Clear the queue"
Write-Host ""
Write-Host "Run /reflect-yourself at the end of your session!"
