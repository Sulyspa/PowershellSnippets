# Define the path to the CSV file and the output JSON file
$csvFilePath = "$PSScriptroot\tokenlist.csv"
$jsonFilePath = "$PSScriptroot\output.json"

# Import the CSV file
$data = Import-Csv -Path $csvFilePath

# Initialize the JSON structure
$jsonData = @{
    "@context" = "#$delta"
    "value" = @()
}

# Iterate through each row in the CSV and add it to the JSON structure
$contentId = 1
foreach ($row in $data) {
    $jsonData.value += @{
        "@contentId" = $contentId.ToString()
        "serialNumber" = $row.Serial
        "manufacturer" = "Feitian"
        "model" = "HardwareToken"
        "secretKey" = $row.Secret
        "timeIntervalInSeconds" = 30
        "hashFunction" = "hmacsha1"
    }
    $contentId++
}

# Convert the PowerShell object to JSON
$jsonOutput = $jsonData | ConvertTo-Json -Depth 3

# Save the JSON to a file
Set-Content -Path $jsonFilePath -Value $jsonOutput

Write-Host "JSON file created successfully at $jsonFilePath"
