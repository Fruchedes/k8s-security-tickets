#!/bin/bash

# Directory to store the manifests
MANIFEST_DIR="k8s_manifest"

# Create the manifest directory if it doesn't exist
mkdir -p $MANIFEST_DIR

# Get all namespaces in the cluster
namespaces=$(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}')

# Loop through each namespace
for ns in $namespaces; do
  echo "Fetching resources for namespace: $ns"

  # Create a subdirectory for each namespace
  ns_dir="$MANIFEST_DIR/$ns"
  mkdir -p $ns_dir

  # Fetch all resources in the namespace
  resources=$(kubectl api-resources --verbs=list --namespaced -o name)

  # Loop through each resource and get its manifest
  for resource in $resources; do
    echo "Fetching $resource in namespace: $ns"
    kubectl get $resource -n $ns -o yaml > "$ns_dir/$resource.yaml" 2>/dev/null
done
done

echo "Manifests saved in the $MANIFEST_DIR directory."