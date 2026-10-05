param(
  [switch]$Strict
)

$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$manifestRoot = Join-Path $root "manifests"
$files = Get-ChildItem -Path $manifestRoot -Recurse -Filter *.yaml
$kustomizations = Get-ChildItem -Path $manifestRoot -Recurse -Filter kustomization.yaml

if (-not $files) {
  Write-Error "No manifest files found."
}

foreach ($file in $files) {
  if ($Strict) {
    Write-Host "Strict-validating $($file.FullName)"
    kubectl apply --dry-run=client -f $file.FullName

    if ($LASTEXITCODE -ne 0) {
      throw "Validation failed for $($file.FullName)"
    }
  } else {
    foreach ($kustomization in $kustomizations) {
      $directory = Split-Path -Parent $kustomization.FullName
      Write-Host "Rendering $directory"
      kubectl kustomize $directory | Out-Null

      if ($LASTEXITCODE -ne 0) {
        throw "Manifest rendering failed for $directory"
      }
    }

    break
  }
}

Write-Host "Manifest validation completed."

$helmCommand = Get-Command helm -ErrorAction SilentlyContinue
$helmPath = $null
$bundledHelm = "C:\Program Files (x86)\windows-amd64\helm.exe"

if ($helmCommand) {
  $helmPath = $helmCommand.Source
} elseif (Test-Path -LiteralPath $bundledHelm) {
  $helmPath = $bundledHelm
}

if ($helmPath) {
  Write-Host "Rendering Helm chart"
  & $helmPath template cloudshop-service (Join-Path $root "charts/cloudshop-service") | Out-Null

  if ($LASTEXITCODE -ne 0) {
    throw "Helm chart rendering failed."
  }
} else {
  Write-Host "Helm not found; skipping chart rendering."
}
