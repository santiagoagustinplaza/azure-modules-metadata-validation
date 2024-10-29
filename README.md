# Azure Modules Metadata Validation

This Terraform module generates a standardized name for resources based on the provided `environment`, `project_id`, `location`, and a `provided_name`. It outputs the `constructed_name`(whose length does not exceed 24 characters) in the format `"env_code"+"project_id"+"location_code"+"provided_name"` using preset codes for the environment and location. It validates the allowed `project_id` list for resource deployment. The module also outputs a standardized set of `tags` for tracking resource metadata and ensures that the resources can be deployed on an appropiate resource group validating it with its tags. For this it requires the `resource_group_name`.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.3 |

## Usage

```hcl
module "metadata_validation" {
  source = "./modules/metadata_validation"

  resource_name       = "myResource"
  environment         = "production"
  project_id          = "2345"
  location            = "centralus"
  resource_group_name = "myResourceGroup"
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment of the resource (must be 'production' or 'development') | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure location of the resource | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID (4 numeric characters) | `string` | n/a | yes |
| <a name="input_provided_name"></a> [provided\_name](#input\_provided\_name) | The name of the resource to construct the full name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_constructed_name"></a> [constructed\_name](#output\_constructed\_name) | Output for the constructed name |
| <a name="output_tags"></a> [tags](#output\_tags) | Output for the tags |
