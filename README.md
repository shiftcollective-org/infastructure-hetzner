# Infrastructure-Hetzner

This repository contains the code that manages our infrastructure in [Hetzner](hetzner.cloud).

This code uses the `hcloud` Terraform provider, for which the documentation can be found [here](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs).

## CI/CD

The code in this repository should **not** be applied manually, and instead should follow the usual branching mechanism.
To make a change, the process should be roughly the following:

1. Make a branch for this repository
2. Change the code in the appropriate location, to create a new server, new network, etc.
3. Open a Pull Request to merge into the main branch.
4. Within the Pull Requests, a number of checks should trigger, for each subfolder in the `tf` path. These checks should include the Terraform `plan`, which you can check to see what the code is actually going to do.
5. Once the PR has been reviewed and approved, merge it. This should trigger an additional Github Action that will `apply` Terraform.

## Path Structure

The path structure in this repo is aimed for a medium-sized organization (following roughly [this document](https://www.terraform-best-practices.com/examples/terraform/medium-size-infrastructure)).

The structure looks like the following:

```
├── README.md
└── tf
    ├── dev
    │   ├── bastion.tf
    │   ├── locals.tf
    │   ├── main.tf
    │   ├── network.tf
    │   ├── outputs.tf
    │   ├── variables.tf
    ├── management
    │   ├── locals.tf
    │   ├── main.tf
    │   ├── network.tf
    │   ├── variables.tf
    ├── modules
    └── README.md
```

The `tf` folder contains all the Terraform code.
Under this folder, there is a dedicated path for each environment. From Terraform perspective, these are completely separate executions, which means that it's possible to run `terraform plan` in the `tf/dev/` path and in the `tf/management/` path separately.

This has some disadvantages, most notably that global resources are _not_ by default visible in different environments directly, and if they are needed, they need to be imported via a `data` block or using the `remote_state` feature.
However, this approach has also advantages:

1. Plan (and apply) runs take less time, since resources are segmented.
2. The blast radius in case of an error (for example in a module) is smaller, as just one environment (at a time) is considered.
3. It is easier to test upgrades of the Terraform provider itself, as the upgrade can be done only for the development environment, before rolling it out to all the other environments as well.

## Terraform Lock File

The `.terraform.lock.hcl` files should be included in version control for more consistent reproducibility.
