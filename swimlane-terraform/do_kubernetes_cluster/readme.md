### Providers

| Name | Version |
|------|---------|
| digitalocean | ~> 2.0 |

### Required ENV variable (DO auth)

```
export TF_VAR_do_client_token=<Your DO token>
```

### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:-----:|
| do\_client\_token | Token required for auth | `string` | yes |
| cluster\_name | Cluster name | `string` | yes |
| kubernetes\_version | The EKS Kubernetes version | `string` | yes |
| node\_pool.auto\_scale | Enable cluster autoscaling | `bool` | yes |
| node\_pool.auto\_upgrade | Whether the cluster will be automatically upgraded | `bool` | yes |
| node\_pool.max\_nodes | Autoscaling maximum node capacity | `string` | no |
| node\_pool.min\_nodes | Autoscaling Minimum node capacity | `string` | no |
| node\_pool.node\_count | The number of Droplet instances in the node pool. | `number` | yes |
| region | The location of the cluster | `string` | yes |
| size | The slug identifier for the type of Droplet to be used as workers in the node pool. | `string` | yes |
| tags | The list of instance tags applied to the cluster. | `list` | no |
