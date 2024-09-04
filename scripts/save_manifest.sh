#!/bin/bash

# Define the directory where you want to save the manifests
OUTPUT_DIR="k8s_manifests"

# Create the output directory if it does not exist
mkdir -p "$OUTPUT_DIR"

# List of resource types to fetch
RESOURCE_TYPES=("pods" "deployments" "services" "configmaps" "secrets" "namespaces" "replicasets" "statefulsets" "daemonsets" "jobs" "cronjobs")

# Loop through each resource type and save the manifests to individual YAML files
for RESOURCE in "${RESOURCE_TYPES[@]}"; do
    echo "Fetching $RESOURCE..."

    # Fetch the resource and save to a YAML file
    if kubectl get "$RESOURCE" --all-namespaces -o yaml > "$OUTPUT_DIR/${RESOURCE}.yaml" 2>/dev/null; then
        echo "$RESOURCE saved to $OUTPUT_DIR/${RESOURCE}.yaml"
    else
        echo "Failed to fetch $RESOURCE or no $RESOURCE found."
    fi
done

echo "All manifests have been saved to $OUTPUT_DIR."