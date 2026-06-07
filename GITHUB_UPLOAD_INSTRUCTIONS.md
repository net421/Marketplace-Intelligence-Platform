# GitHub Upload Instructions

This package includes `UPLOAD_TO_GITHUB.bat`, which can create and push the repository automatically using Git and GitHub CLI.

## Before running

1. Install Git.
2. Install GitHub CLI.
3. Open Command Prompt in this folder.
4. Run:

```bat
gh auth login
UPLOAD_TO_GITHUB.bat
```

## Default repository

The script creates:

```text
Marketplace-Intelligence-Platform
```

Public repository with topics for analytics, business intelligence, marketplace analytics, decision intelligence, dashboards, customer analytics, seller analytics, network science, Python, and data visualization.

## To change the repository name

Open `UPLOAD_TO_GITHUB.bat` and edit:

```bat
set "REPO_NAME=Marketplace-Intelligence-Platform"
```
