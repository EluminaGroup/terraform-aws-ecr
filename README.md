# terraform-aws-ecr

This terraform module creates an Amazon Web Services (AWS) Elastic Container Registry (ECR) repository.

The following resources will be created:

 - ECR Repository
   - Set the Amazon ECR image scanning on push  = true
      - Amazon ECR image scanning helps in identifying software vulnerabilities in your container images.
 - ECR policies
 - Create a ECR lifecyle
    - Expire images older than 14 days
    - Expire images with feature tag
    - Expire images with the same tag

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.31 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kms\_key\_arn | KMS Key ARN to use a CMK instead of default key | `string` | n/a | yes |
| name | Name for ECR repository | `any` | n/a | yes |
| trust\_accounts | Accounts to trust and allow ECR fetch | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ecr\_arn | n/a |
| ecr\_name | n/a |
| ecr\_url | n/a |

<!--- END_TF_DOCS --->

## Authors

Module managed by [Elumina Group](https://github.com/EluminaGroup).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/EluminaGroup/terraform-aws-ecr/blob/master/LICENSE) for full details.
