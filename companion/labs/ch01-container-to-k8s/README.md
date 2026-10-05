# Lab 1: From Container to Kubernetes Intent

This lab supports Chapter 1.

## Goal

Inspect the first CloudShop Deployment and identify what it does and does not promise.

## Review

Open:

```text
../../manifests/chapter01/product-service-deployment.yaml
```

Questions:

- What desired state is declared?
- What production questions are still unanswered?
- Which concerns are absent: resources, probes, service discovery, security, rollout, and recovery?

## Optional Dry Run

```bash
kubectl apply --dry-run=client -f ../../manifests/chapter01/product-service-deployment.yaml
```

Do not deploy the manifest unchanged. The image is a placeholder.

