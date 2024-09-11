# Kubernetes provider using AKS credentials
provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks.kube_config[0].host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
}

# Kubernetes deployment resource
resource "kubernetes_deployment" "hello_world" {
  metadata {
    name      = "hello-world-api"
    namespace = "default"
  }

  spec {
    replicas = 1

 selector {
      match_labels = {
        app = "hello-world-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "hello-world-api"
        }
      }

      spec {
        container {
          name  = "hello-world-api"
          image = "testacrcgi.azurecr.io/hello-world-apiv3:v1"  # Replace with your ACR image
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

# Kubernetes service resource
resource "kubernetes_service" "hello_world_service" {
  metadata {
    name      = "hello-world-api-service"
    namespace = "default"
  }

  spec {
    type = "LoadBalancer"

    selector = {
      app = "hello-world-api"
    }

    port {
      port        = 80
      target_port = 8080
    }
  }
}
