Resource Quotas

Resource quotas are used to manage resources (CPU, memory, etc.) across a namespace.

Set Resource Quota:
Create a YAML file for the resource quota.

apiVersion: v1
kind: ResourceQuota
metadata:
  name: resource-quota
  namespace: my-namespace
spec:
  hard:
    pods: "10"
    requests.cpu: "4"
    requests.memory: 16Gi
    limits.cpu: "8"
    limits.memory: 32Gi
Apply Resource Quota:

kubectl apply -f resource-quota.yaml

Verify Resource Quota:

kubectl get resourcequota -n my-namespace


Testing Resource Quotas
Apply Resource Quotas and Limits:
Ensure your namespace and application-level resource quotas and limits are applied.


kubectl apply -f namespace-quota.yaml
kubectl apply -f app-limit-range.yaml
Deploy a Pod within Quota:
Deploy a pod that requests resources within the defined quotas and limits.


kubectl run test-pod --image=nginx --requests='cpu=500m,memory=512Mi' --limits='cpu=1,memory=1Gi' -n my-namespace
Check if the pod is successfully created:


kubectl get pods -n my-namespace
Deploy a Pod Exceeding Quota:
Deploy a pod that requests resources exceeding the defined quotas and limits.


kubectl run test-pod-2 --image=nginx --requests='cpu=3,memory=20Gi' --limits='cpu=4,memory=25Gi' -n my-namespace
Check if the pod creation fails due to exceeding resource quotas:


kubectl get pods -n my-namespace
kubectl describe quota namespace-quota -n my-namespace
Check Resource Usage:
Verify the resource usage in the namespace:


kubectl describe quota namespace-quota -n my-namespace
kubectl describe limitrange app-limit-range -n my-namespace

