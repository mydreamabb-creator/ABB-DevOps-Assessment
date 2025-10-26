# Azure Monitor Setup for AKS

## 1. Monitoring Enabled
Azure Monitor (Container Insights) enabled on AKS cluster using Log Analytics workspace `aks-monitoring-workspace`.

## 2. Alert Rules Configured
| Alert Name | Metric | Threshold | Severity | Frequency | Action Group |
|-------------|---------|------------|-----------|-------------|--------------|
| AKS-High-CPU | Average Node CPU Usage (%) | > 80 | Sev 2 | Every 5 min | AKS-Alerts-Group |
| AKS-High-Memory | Average Node Memory Usage (%) | > 80 | Sev 3 | Every 5 min | AKS-Alerts-Group |

## 3. Notifications
Action group `AKS-Alerts-Group` sends email notification to devops-team@example.com.

## 4. Test Alert
A test pod generating CPU load triggered the AKS-High-CPU alert, visible under Azure Monitor → Alerts → Fired Alerts.

## 5. Evidence
- Screenshot: Cluster Insights Overview
- Screenshot: Alert Rule configuration (CPU)
- Screenshot: Alert Rule configuration (Memory)
- Screenshot: Fired Alerts list
