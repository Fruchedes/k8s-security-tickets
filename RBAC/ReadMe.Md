To create an RBAC (Role-Based Access Control) setup that allows users to create, edit, and modify service accounts, you will need to define the appropriate Role or ClusterRole along with corresponding RoleBinding or ClusterRoleBinding. Here’s a step-by-step guide:

1. Understand RBAC Components


Role: Defines a set of permissions within a specific namespace. Use this if you want to limit permissions to a specific namespace.

ClusterRole: Defines a set of permissions across the entire cluster. Use this if you want to grant permissions cluster-wide.

RoleBinding: Grants the permissions defined in a Role to a user or group within a specific namespace.

ClusterRoleBinding: Grants the permissions defined in a ClusterRole to a user or group across the entire cluster.

2. Create a ClusterRole (for cluster-wide access)

If you want to give permissions across the entire cluster, create a ClusterRole. Here’s an example YAML for a ClusterRole that allows users to create, edit, and delete service accounts:


apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: service-account-admin
rules:
- apiGroups: [""]
  resources: ["serviceaccounts"]
  verbs: ["create", "get", "list", "watch", "update", "patch", "delete"]

3. Create a ClusterRoleBinding
Bind the ClusterRole to a user, group, or service account using a ClusterRoleBinding. Here’s an example YAML:

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: service-account-admin-binding
subjects:
- kind: User
  name: <USERNAME>  # Replace <USERNAME> with the actual user or service account name
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: service-account-admin
  apiGroup: rbac.authorization.k8s.io

4. Create a Role and RoleBinding (for namespace-specific access)
If you only need to grant permissions within a specific namespace, use a Role and RoleBinding:

Role

apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: service-account-admin
  namespace: <NAMESPACE>  # Replace <NAMESPACE> with your target namespace
rules:
- apiGroups: [""]
  resources: ["serviceaccounts"]
  verbs: ["create", "get", "list", "watch", "update", "patch", "delete"]


RoleBinding

apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: service-account-admin-binding
  namespace: <NAMESPACE>  # Replace <NAMESPACE> with your target namespace
subjects:
- kind: User
  name: <USERNAME>  # Replace <USERNAME> with the actual user or service account name
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: service-account-admin
  apiGroup: rbac.authorization.k8s.io


5. Apply the YAML Files
Save the above YAML configurations to files and apply them using kubectl:


kubectl apply -f <filename>.yaml
6. Verify Permissions
To verify that the user has the correct permissions, you can use the kubectl auth can-i command:


kubectl auth can-i create serviceaccounts --as <USERNAME>  # Check if the user can create service accounts
Replace <USERNAME> with the actual username or service account name.

This setup will allow users to create, modify, and delete service accounts according to the specified RBAC rules.