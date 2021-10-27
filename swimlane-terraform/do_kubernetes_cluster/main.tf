resource "digitalocean_kubernetes_cluster" "swimlane" {
  name         = var.cluster_name
  region       = var.region
  version      = var.kubernetes_version
  auto_upgrade = true
  tags         = var.tags
  node_pool {
    name       = var.node_pool["node_name"]
    size       = var.node_pool["node_size"]
    node_count = var.node_pool["node_count"]
    auto_scale = var.node_pool["auto_scale"]
    min_nodes  = var.node_pool["min_nodes"]
    max_nodes  = var.node_pool["max_nodes"]
  }
  maintenance_policy {
    start_time = var.maintenance_policy["start_time"]
    day        = var.maintenance_policy["day"]
  }
}