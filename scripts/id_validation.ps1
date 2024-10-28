param (
    [string]$project_id
)

# List of banned project IDs
$bannedProjectIDs = Get-Content -Path "./scripts/banned_ids.txt"

# Check if the project_id is exactly 4 digits
if ($project_id.Length -eq 4 -and $project_id -match '^\d{4}$') {
    # Check if the project_id is banned
    if ($bannedProjectIDs -contains $project_id) {
        Write-Host "Error: The project ID '$project_id' is banned."
        exit 1
    } else {
        Write-Host "The project ID '$project_id' is valid."
        exit 0
    }
} else {
    Write-Host "Error: The project ID '$project_id' must be exactly 4 numeric characters."
    exit 1
}