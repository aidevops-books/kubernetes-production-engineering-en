# Lab 2: Workload Contract

This lab supports Chapter 2.

## Goal

Map the CloudShop workload contract to Kubernetes objects.

## Review

Open:

```text
../../manifests/chapter02/cloudshop-workload-contract.yaml
```

Find the implementation of each contract area:

- artifact
- configuration
- secret placeholder
- Service discovery
- startup, readiness, and liveness probes
- graceful shutdown

## Optional Dry Run

```bash
kubectl apply --dry-run=client -f ../../manifests/chapter02/cloudshop-workload-contract.yaml
```

Production note: storing secrets directly in Git is not acceptable. The included Secret exists only to show the object boundary.

