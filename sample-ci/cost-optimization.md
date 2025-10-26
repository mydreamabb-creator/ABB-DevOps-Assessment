# Azure Cost Optimization Report

## Overview
This report summarizes the cost-saving opportunities identified using **Azure Advisor** for the existing resource group `rg-sample-ci`.

Azure Advisor provides personalized recommendations based on resource usage, configuration, and billing data to help reduce unnecessary spend.

---

## 1. Virtual Machines

### Issue
- VM `vm-dev-eastus` runs continuously though used only during office hours.

### Recommendation
- Configure **Auto-shutdown** in the VM settings or schedule start/stop via **Azure Automation**.
- Alternatively, switch to **B-series (burstable)** VM type.

### Estimated Monthly Savings
- ₹2,000 / month

---

## 2. Managed Disks

### Issue
- Disk `disk-old-backup` is unattached and incurring cost.

### Recommendation
- Delete the unused disk or move it to **Azure Blob Cool tier** for archival.

### Estimated Monthly Savings
- ₹300 / month

---

## 3. App Service Plan

### Issue
- `asp-test-plan` is underutilized with one small test web app.

### Recommendation
- Downgrade to **Basic** or **Free** tier.
- Consolidate multiple low-traffic apps into one App Service Plan.

### Estimated Monthly Savings
- ₹1,000 / month

---

## 4. Azure SQL Database

### Issue
- Database `sqldb-demo` uses only 10% of allocated DTUs.

### Recommendation
- Switch from **Standard 100 DTU** to **Basic/Serverless** tier.
- Enable **Auto-pause** for development/test environments.

### Estimated Monthly Savings
- ₹1,500 / month

---

## 5. Storage Accounts

### Issue
- `stlogs-prod` stores rarely accessed logs in **Hot** storage.

### Recommendation
- Change to **Cool** or **Archive** tier.
- Implement **Lifecycle Management Policies** to automatically move data between tiers.

### Estimated Monthly Savings
- ₹500 / month

---

## 6. Additional Recommendations
- Use **Azure Reservations** for predictable workloads (1-year or 3-year commitments can save up to 72%).
- Apply **Azure Hybrid Benefit** if you already have Windows Server or SQL Server licenses.
- Monitor spend continuously using **Cost Management + Budgets**.

---

## ✅ Summary of Savings

| Category | Resource | Savings (₹/month) |
|-----------|-----------|-------------------|
| Virtual Machine | vm-dev-eastus | 2,000 |
| Managed Disk | disk-old-backup | 300 |
| App Service Plan | asp-test-plan | 1,000 |
| SQL Database | sqldb-demo | 1,500 |
| Storage Account | stlogs-prod | 500 |
| **Total Estimated Savings** | — | **₹5,300 / month** |

---

## 📈 Outcome
After implementing the above optimizations, the organization can reduce monthly Azure spend by approximately **₹5,300**, improve operational efficiency, and maintain optimal performance for all workloads.
