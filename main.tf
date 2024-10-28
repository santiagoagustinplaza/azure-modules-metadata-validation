locals {
  # Map for location codes
  location_map = {
    "centralus"          = "usc"
    "eastasia"           = "ase"
    "eastus"             = "use"
    "eastus2"            = "use2"
    "westus"             = "usw"
    "westus2"            = "usw2"
    "northeurope"        = "eun"
    "southeastasia"      = "apsa"
    "southindia"         = "ins"
    "uksouth"            = "uks"
    "ukwest"             = "ukw"
    "westcentralus"      = "uswc"
    "westeurope"         = "euw"
    "westindia"          = "inw"
    "northcentralus"     = "usnc"
    "germanywestcentral" = "gwc"
    "germanynorth"       = "gnt"
    "southcentralus"     = "scus"
    "australiaeast"      = "aue"
    "australiacentral"   = "auc"
    "australiasoutheast" = "ause"
    "centralindia"       = "indc"
    "canadacentral"      = "cac"
    "canadaeast"         = "cae"
    "swedencentral"      = "sdc"
    "italynorth"         = "itn"
    "norwayeast"         = "nye"
    "norwaywest"         = "nyw"
    "francecentral"      = "frc"
    "francesouth"        = "frs"
    "polandcentral"      = "plc"
    "switzerlandnorth"   = "sln"
    "switzerlandwest"    = "slw"
    "japaneast"          = "jpe"
    "japanwest"          = "jpw"
    "koreacentral"       = "koc"
    "brazilsoutheast"    = "bse"
    "southafricanorth"   = "sfn"
    "southafricawest"    = "sfw"
  }

  # Map for environment codes
  env_map = {
    "production"  = "p"
    "development" = "d"
  }

  # Validate inputs
  location_code = lookup(local.location_map, var.location)
  env_code      = lookup(local.env_map, var.environment)

  # Construct the name
  constructed_name = substr("${local.env_code}${var.project_id}${local.location_code}${var.provided_name}", 0, 24)

  # Construct tags
  tags = {
    "environment" = var.environment
    "project_id"  = var.project_id
    "location"    = var.location
  }
}

# Null resource to run the external PowerShell validation script
resource "null_resource" "validate_project_id" {
  provisioner "local-exec" {
    # Call the PowerShell script and pass the project_id variable as a parameter
    command = "powershell -File ./scripts/id_validation.ps1 -project_id ${var.project_id}"

    # Pass variables as environment variables to the script
    environment = {
      project_id = var.project_id
    }
  }
  triggers = {
    project_id = var.project_id
  }
}

resource "null_resource" "validate_project_id_tag" {
  depends_on = [ null_resource.validate_project_id ]
  provisioner "local-exec" {
    # Call the PowerShell script and pass the resource group name, project_id, environment, and location as parameters
    command = "powershell -File ./scripts/rg_tags_validation.ps1 -resource_group_name ${var.resource_group_name} -project_id ${var.project_id} -environment ${var.environment} -location ${var.location}"

    # Pass variables as environment variables to the script
    environment = {
      project_id          = var.project_id
      environment         = var.environment
      location            = var.location
      resource_group_name = var.resource_group_name
    }
  }
  triggers = {
    project_id          = var.project_id
    environment         = var.environment
    location            = var.location
    resource_group_name = var.resource_group_name
  }
}