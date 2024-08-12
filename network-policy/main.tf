# Create a Kubernetes namespace
resource "kubernetes_namespace" "example" {
  metadata {
    name = "test-namespace"
  }
}

# Create the first pod
resource "kubernetes_pod" "pod1" {
    depends_on = [ kubernetes_namespace.example ]
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
