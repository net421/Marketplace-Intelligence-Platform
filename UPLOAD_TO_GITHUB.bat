@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM Marketplace Intelligence Platform - GitHub Upload Script
REM Requires: Git, GitHub CLI (gh), and prior `gh auth login`
REM ============================================================

set "REPO_NAME=Marketplace-Intelligence-Platform"
set "REPO_DESCRIPTION=Executive marketplace analytics platform with dashboards, KPI reporting, customer intelligence, seller risk, network science, and decision intelligence."
set "VISIBILITY=public"

echo.
echo ============================================================
echo  Marketplace Intelligence Platform - GitHub Deployment
echo ============================================================
echo.

where git >nul 2>nul
if errorlevel 1 (
    echo ERROR: Git is not installed or not available in PATH.
    pause
    exit /b 1
)

where gh >nul 2>nul
if errorlevel 1 (
    echo ERROR: GitHub CLI is not installed or not available in PATH.
    pause
    exit /b 1
)

gh auth status >nul 2>nul
if errorlevel 1 (
    echo ERROR: GitHub CLI is not authenticated.
    echo Run: gh auth login
    pause
    exit /b 1
)

echo Repository name: %REPO_NAME%
echo Visibility: %VISIBILITY%
echo.

if not exist ".git" (
    echo Initializing local Git repository...
    git init
)

echo Setting default branch to main...
git branch -M main

echo Adding files...
git add .

echo Creating commit...
git commit -m "Initial release: Marketplace Intelligence Platform v1" || echo Nothing new to commit.

echo.
echo Checking whether GitHub repository already exists...
gh repo view "%REPO_NAME%" >nul 2>nul
if errorlevel 1 (
    echo Creating GitHub repository...
    gh repo create "%REPO_NAME%" --%VISIBILITY% --description "%REPO_DESCRIPTION%" --source=. --remote=origin --push
) else (
    echo Repository already exists. Connecting remote and pushing...
    git remote remove origin >nul 2>nul
    for /f "tokens=*" %%i in ('gh api user --jq ".login"') do set "GITHUB_OWNER=%%i"
    git remote add origin "https://github.com/!GITHUB_OWNER!/%REPO_NAME%.git"
    git push -u origin main
)

echo.
echo Adding repository topics...
gh repo edit "%REPO_NAME%" ^
  --add-topic business-intelligence ^
  --add-topic analytics ^
  --add-topic marketplace-analytics ^
  --add-topic decision-intelligence ^
  --add-topic executive-dashboard ^
  --add-topic customer-analytics ^
  --add-topic seller-analytics ^
  --add-topic network-science ^
  --add-topic python ^
  --add-topic data-visualization

echo.
echo ============================================================
echo DONE.
echo Repository should be available at:
gh repo view "%REPO_NAME%" --web
echo ============================================================
pause
