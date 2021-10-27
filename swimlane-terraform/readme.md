# Readme 

## Scope
Admittently I left some things out of scope for this test, normally I'd put this in a terraform workspace and abstract from the module and build on top of it, however I'm building direct from the little module I've created down below for brevity. If this were a real world project I'd have another module for firewall access and I'd tie them together from the root here along with other modules. 

## CLI-History
```
~/Documents/swimlane/swimlane-terraform/do_kubernetes_cluster
❯ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # digitalocean_kubernetes_cluster.swimlane will be created
  + resource "digitalocean_kubernetes_cluster" "swimlane" {
      + auto_upgrade   = true
      + cluster_subnet = (known after apply)
      + created_at     = (known after apply)
      + endpoint       = (known after apply)
      + ha             = false
      + id             = (known after apply)
      + ipv4_address   = (known after apply)
      + kube_config    = (sensitive value)
      + name           = "swimlane-k8s"
      + region         = "nyc1"
      + service_subnet = (known after apply)
      + status         = (known after apply)
      + surge_upgrade  = true
      + tags           = [
          + "owner_alucas",
        ]
      + updated_at     = (known after apply)
      + urn            = (known after apply)
      + version        = "1.21.5-do.0"
      + vpc_uuid       = (known after apply)

      + maintenance_policy {
          + day        = "sunday"
          + duration   = (known after apply)
          + start_time = "06:00"
        }

      + node_pool {
          + actual_node_count = (known after apply)
          + auto_scale        = true
          + id                = (known after apply)
          + max_nodes         = 2
          + min_nodes         = 1
          + name              = "swimlane-default-nodepool"
          + node_count        = 2
          + nodes             = (known after apply)
          + size              = "s-1vcpu-2gb"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

digitalocean_kubernetes_cluster.swimlane: Creating...
digitalocean_kubernetes_cluster.swimlane: Still creating... [10s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [20s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [30s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [40s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [50s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [1m0s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [1m10s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [1m20s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [1m30s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [1m40s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [1m50s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [2m0s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [2m10s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [2m20s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [2m30s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [2m40s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [2m50s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [3m0s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [3m10s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [3m20s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [3m30s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [3m40s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [3m50s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [4m0s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [4m10s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [4m20s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [4m30s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [4m40s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [4m50s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [5m0s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [5m10s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [5m20s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [5m30s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [5m40s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [5m50s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [6m0s elapsed]
digitalocean_kubernetes_cluster.swimlane: Still creating... [6m10s elapsed]
digitalocean_kubernetes_cluster.swimlane: Creation complete after 6m12s [id=4055be6e-5488-4cff-9fa1-441137ccb331]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

```