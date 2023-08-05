## Hetzner Infrastructure

At the moment the following decisions have been taken:

1. Each environment has assigned a full network (not a subnet). There are currently not many features for subnets that are useful, and they are not as well supported as Terraform resources as the main networks (for example, no `data` support).
2. Modules are developed globally and stored in the `modules` folder. Modules can be, for example "Kuberentes nodes" including all the necessary firewall rules or whatever else is needed.
