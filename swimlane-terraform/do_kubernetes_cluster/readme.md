### Providers

| Name | Version |
|------|---------|
| digitalocean | ~> 2.0 |

### Required ENV variable (DO auth)

```
export TF_VAR_do_client_token=<Your DO token>
```

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| do\_client\_token | Token required for auth | `string` | n/a | yes |
| node\_pool.auto\_scale | Enable cluster autoscaling | `bool` | n/a | yes |
| node\_pool.auto\_upgrade | Whether the cluster will be automatically upgraded | `bool` | n/a | yes |
| cluster\_name | Cluster name | `string` | n/a | yes |
| kubernetes\_version | The EKS Kubernetes version | `string` | n/a | yes |
| node\_pool.max\_nodes | Autoscaling maximum node capacity | `string` | `5` | no |
| node\_pool.min\_nodes | Autoscaling Minimum node capacity | `string` | `1` | no |
| node\_pool.node\_count | The number of Droplet instances in the node pool. | `number` | n/a | yes |
| region | The location of the cluster | `string` | n/a | yes |
| size | The slug identifier for the type of Droplet to be used as workers in the node pool. | `string` | n/a | yes |
| tags | The list of instance tags applied to the cluster. | `list` | <pre>[<br>  "kubernetes"<br>]</pre> | no |
