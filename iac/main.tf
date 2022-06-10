terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
    token = "dop_v1_2ea747921b6acb999dab346a5f38f27dbeb1feb86e9b8f7ddcbdf3cc34975364"
}

resource "digitalocean_kubernetes_cluster" "k8s_iniciativa" {
    name = "k8s-iniciativa"
    region = "nyc1"
    version = "1.22.8-do.1"

    node_pool {
      name          = "default"
      size          = "s-2vcpu-2gb"
      node_count    = 3
    }
}

output "kube_endpoint" {
  value = digitalocean_kubernetes_cluster.k8s_iniciativa.endpoint
}

resource "local_file" "kube_config" {
  content = digitalocean_kubernetes_cluster.k8s_iniciativa.kube_config.0.raw_config
  filename = "kube_config.yaml"
}
  
