# Branching Strategy – GitHub Collaboration Demo

## 📘 Overview
This document describes the branching strategy, pull request workflow, and code review process used in the **devops-branching-demo** repository.  
The goal is to demonstrate a clean, collaborative Git workflow suitable for DevOps projects using Azure DevOps or GitHub Actions for CI/CD.

---

## 🌿 Branch Types and Purpose

| Branch Type | Naming Convention | Purpose |
|--------------|-------------------|----------|
| `main` | `main` | Stable production-ready code. Only tested, approved code is merged here. |
| `develop` | `develop` | Integration branch for ongoing development before release. |
| `feature` | `feature/<feature-name>` | For new features or enhancements. Example: `feature/add-login-api`. |
| `bugfix` | `bugfix/<issue-description>` | For fixing minor issues or hotfixes before release. |
| `release` | `release/<version>` | For preparing new releases. Example: `release/v1.0`. |
| `hotfix` | `hotfix/<critical-fix>` | For urgent fixes directly into production. Example: `hotfix/fix-login-crash`. |

---

## ⚙️ Workflow Summary

### 1️⃣ **Start a New Feature**
- Always create a new branch from `main` or `develop`:
  ```bash
  git checkout main
  git pull origin main
  git checkout -b feature/add-login-api
