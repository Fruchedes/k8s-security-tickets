Liveness Probes

Liveness probes are used to determine if an application is running. If the liveness probe fails, Kubernetes will restart the container.

Set Liveness Probe:

Open your application's deployment YAML file.
Add the liveness probe configuration under the containers section.

apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-application
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-application
  template:
    metadata:
      labels:
        app: my-application
    spec:
      containers:
      - name: my-container
        image: my-image:latest
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8080
          initialDelaySeconds: 3
          periodSeconds: 10
Configure Probes:

httpGet: Probes the HTTP endpoint.
initialDelaySeconds: The time to wait before starting to probe.
periodSeconds: How often to perform the probe.


Types of Probes and How to Implement Them

HTTP GET Probe:
Used for applications that expose HTTP endpoints for health checks.

livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 3
  periodSeconds: 10

readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10

TCP Socket Probe:
Used for applications that listen on a TCP port.

livenessProbe:
  tcpSocket:
    port: 8080
  initialDelaySeconds: 3
  periodSeconds: 10

readinessProbe:
  tcpSocket:
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10

Exec Probe:
Runs a command inside the container to determine its health.

livenessProbe:
  exec:
    command:
    - cat
    - /tmp/healthy
  initialDelaySeconds: 3
  periodSeconds: 10

readinessProbe:
  exec:
    command:
    - cat
    - /tmp/ready
  initialDelaySeconds: 5
  periodSeconds: 10

Testing Liveness and Readiness Probes

Deploy the Application:
Ensure your application deployment YAML includes the liveness and readiness probes.


kubectl apply -f my-application-deployment.yaml
Check Pod Status:
Monitor the status of the pods to ensure they are being correctly restarted or marked as ready/unready based on the probe results.


kubectl get pods -w

Simulate Failure:
To test the liveness probe, you can simulate a failure by temporarily breaking the endpoint or command the probe checks.

For HTTP GET probe:

Modify the application to return a non-200 HTTP status code on the /healthz endpoint.

For TCP Socket probe:

Stop the service listening on the TCP port.

For Exec probe:

Remove or alter the file or command the probe checks.
Observe if Kubernetes restarts the container as expected.

Verify Readiness:
To test the readiness probe, you can simulate readiness failure similarly:

For HTTP GET probe:

Modify the application to return a non-200 HTTP status code on the /ready endpoint.
For TCP Socket probe:

Stop the service listening on the TCP port.
For Exec probe:

Remove or alter the file or command the probe checks.
Observe if Kubernetes stops sending traffic to the unready pod by checking the service endpoints:


kubectl get endpoints my-service