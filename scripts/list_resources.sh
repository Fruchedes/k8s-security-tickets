#!/bin/bash

echo "Listing all Kubernetes resources..."

# Define an array of resource types
RESOURCE_TYPES=("pods" "deployments" "services" "configmaps" "secrets" "namespaces" "replicasets"  "statefulsets"  "daemonsets" "jobs" "cronjobs" "pv" "pvc")

# Loop through each resource type and run kubectl get for all namespaces
for RESOURCE in "${RESOURCE_TYPES[@]}"; do
    echo -e "\nFetching $RESOURCE..."
    kubectl get "$RESOURCE" --all-namespaces
done

echo -e "\nAll resources have been listed."