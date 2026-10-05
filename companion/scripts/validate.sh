#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

if [ "${1:-}" = "--strict" ]; then
  find "$ROOT/manifests" -name '*.yaml' -type f | sort | while read -r file; do
    echo "Strict-validating $file"
    kubectl apply --dry-run=client -f "$file"
  done
else
  find "$ROOT/manifests" -name 'kustomization.yaml' -type f | sort | while read -r file; do
    dir="$(dirname "$file")"
    echo "Rendering $dir"
    kubectl kustomize "$dir" >/dev/null
  done
fi

echo "Manifest validation completed."

if command -v helm >/dev/null 2>&1; then
  echo "Rendering Helm chart"
  helm template cloudshop-service "$ROOT/charts/cloudshop-service" >/dev/null
else
  echo "Helm not found; skipping chart rendering."
fi
