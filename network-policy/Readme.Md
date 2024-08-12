# Kubernetes Network Policies

## Overview

Kubernetes Network Policies are used to control the communication between pods in a Kubernetes cluster. By default, all pods can communicate with each other, but Network Policies allow you to define rules to control this behavior. This is crucial for enhancing security by restricting which pods can communicate with each other and what traffic is allowed.

## Key Concepts

- **Network Policy**: An API object that defines how pods are allowed to communicate with each other and with other network endpoints. Network policies are implemented by the networking layer (CNI plugin) and are not enforced by the Kubernetes API server itself.
  
- **Selectors**: Network Policies use selectors to define which pods the policy applies to. These selectors are based on labels assigned to pods.

- **Policy Types**: The primary policy types are `Ingress` and `Egress`:
  - **Ingress**: Controls the incoming traffic to the selected pods.
  - **Egress**: Controls the outgoing traffic from the selected pods.

## Creating Network Policies

### Sample Terraform Configuration

Below is a sample Terraform configuration to create a namespace, two pods, and a network policy to restrict communication between the pods based on their labels.

```hcl
provider "kubernetes" {
  # Configure the Kubernetes provider
  config_context = "your-kube-context"  # Update this to your kube context
}

# Create a Kubernetes namespace
resource "kubernetes_namespace" "example" {
  metadata {
    name = "example-namespace"
  }
}

# Create the first pod
resource "kubernetes_pod" "pod1" {
  metadata {
    name      = "pod1"
    namespace = kubernetes_namespace.example.metadata[0].name
    labels = {
      app = "pod1"
    }
  }
  spec {
    container {
      name  = "nginx"
      image = "nginx:latest"
    }
  }
}

# Create the second pod
resource "kubernetes_pod" "pod2" {
  metadata {
    name      = "pod2"
    namespace = kubernetes_namespace.example.metadata[0].name
    labels = {
      app = "pod2"
    }
  }
  spec {
    container {
      name  = "nginx"
      image = "nginx:latest"
    }
  }
}

# Create a network policy to restrict communication between the two pods
resource "kubernetes_network_policy" "restrict_pods" {
  metadata {
    name      = "restrict-pods"
    namespace = kubernetes_namespace.example.metadata[0].name
  }

  spec {
    pod_selector {
      match_labels = {
        app = "pod1"
      }
    }

    policy_types = ["Ingress"]

    ingress {
      from {
        pod_selector {
          match_labels = {
            app = "pod2"
          }
        }
      }
      ports {
        port = 80
      }
    }
  }
}
