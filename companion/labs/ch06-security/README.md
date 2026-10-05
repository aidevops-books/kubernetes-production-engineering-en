# Lab 6: Production Security

This lab supports Chapter 6.

## Goal

Review a minimal security baseline for an application namespace.

## Review

Open:

```text
../../manifests/chapter06/cloudshop-security.yaml
```

Identify:

- Pod Security admission labels
- runtime ServiceAccount
- least-privilege Role and RoleBinding
- non-root runtime settings
- read-only root filesystem
- default-deny NetworkPolicy

## Design Questions

- Does the workload need Kubernetes API access at runtime?
- Which writable paths does the container actually require?
- Which egress flows should be allowed?
- How are secrets delivered, rotated, and revoked?

