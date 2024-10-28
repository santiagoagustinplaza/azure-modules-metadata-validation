param (
    [string]$resource_group_name,
    [string]$project_id,
    [string]$environment,
    [string]$location
)

# Get the resource group tags using Azure CLI
$tags = az group show --name $resource_group_name --query "tags" | ConvertFrom-Json

# Validate if the project_id tag exists and matches the provided project_id
if ($tags.project_id -ne $project_id) {
    Write-Error "The project_id tag in the resource group '$resource_group_name' does not match the provided project_id '$project_id'."
    exit 1
}

# Validate if the environment tag exists and matches the provided environment
if ($tags.environment -ne $environment) {
    Write-Error "The environment tag in the resource group '$resource_group_name' does not match the provided environment '$environment'."
    exit 1
}

# Validate if the location tag exists and matches the provided location
if ($tags.location -ne $location) {
    Write-Error "The location tag in the resource group '$resource_group_name' does not match the provided location '$location'."
    exit 1
}

Write-Host "Project ID, Environment, and Location tag validation passed for resource group: $resource_group_name"
