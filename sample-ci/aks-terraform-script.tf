terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }

  backend "local" {} # simple local backend; change to azurerm backend for team use
}

provider "azurerm" {
  features {}
}

###############################################################################
# Variables (inline default values). Override via terraform.tfvars or CLI
###############################################################################
variable "subscription_id" {
  type        = string
  description = "Azure subscription id"
  default     = ""
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "centralindia"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for AKS and Log Analytics"
  default     = "rg-aks-demo"
}

variable "aks_cluster_name" {
  type        = string
  description = "AKS cluster name"
  default     = "aks-demo-cluster"
}

variable "node_count" {
  type        = number
  description = "Agent node count"
  default     = 2
}

variable "node_vm_size" {
  type        = string
  description = "VM size for agent nodes"
  default     = "Standard_DS2_v2"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version (leave empty for default)"
  default     = ""
}

###############################################################################
# Resource Group
###############################################################################
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    environment = "demo"
    created_by  = "terraform"
  }
}

###############################################################################
# Log Analytics Workspace for Azure Monitor (Container Insights)
###############################################################################
resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.resource_group_name}-law"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = {
    created_by = "terraform"
  }
}

###############################################################################
# AKS cluster with System Assigned Managed Identity and Azure Monitor enabled
###############################################################################
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.aks_cluster_name}-dns"

  default_node_pool {
    name       = "agentpool"
    node_count = var.node_count
    vm_size    = var.node_vm_size
    os_type    = "Linux"
  }

  identity {
    type = "SystemAssigned"
  }

  # Enable Kubernetes RBAC
  role_based_access_control {
    enabled = true
  }

  # Network profile: default kubenet (change to azure CNI if needed)
  network_profile {
    network_plugin = "kubenet"
  }

  # OMS Agent (Azure Monitor) wiring to Log Analytics workspace
  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
    }
  }

  # Optionally set kubernetes version if provided
  dynamic "kubernetes_version" {
    for_each = var.kubernetes_version == "" ? [] : [var.kubernetes_version]
    content {
      # when populated we would set version; left as standard property below instead
    }
  }

  tags = {
    environment = "demo"
  }

  # Note: If your subscription requires specific role permissions for managed identity
  # you may need to assign roles to the principal after creation.
}

###############################################################################
# Optional: Output kubeconfig / cluster info
###############################################################################
output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "kube_config_raw" {
  description = "A base64-encoded kubeconfig (may be empty depending on AzureRM provider). Use 'az aks get-credentials' to fetch kubeconfig locally."
  value       = "" # intentionally empty; use az cli below to fetch credentials securely
  sensitive   = true
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.law.id
}

output "log_analytics_workspace_primary_shared_key" {
  value     = azurerm_log_analytics_workspace.law.primary_shared_key
  sensitive = true
}
