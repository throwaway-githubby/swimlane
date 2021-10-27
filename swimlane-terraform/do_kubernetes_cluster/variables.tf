variable "do_client_token" {
  description = "Your Digitalocean API secret"
}

variable "cluster_name" {
  description = "The name of the kubernetes cluster"
  type        = string
  default     = "swimlane-k8s"
}

variable "region" {
  description = "Location of the cluster"
  type        = string
  default     = "nyc1"
}

variable "kubernetes_version" {
  description = "Version of kubernetes you wish to use"
  default     = "1.21.5-do.0"
}

variable "node_pool" {
  type = map(any)
  default = {
    node_name  = "swimlane-default-nodepool"
    node_size  = "s-1vcpu-2gb"
    node_count = 2
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 2
  }
}

variable "maintenance_policy" {
  type = map(string)
  default = {
    start_time = "06:00"
    day        = "sunday"
  }
}

variable "tags" {
  type    = list(any)
  default = ["owner_alucas"]
}

