# Lab 9: Delivery and GitOps

This lab supports Chapter 9.

## Goal

Separate application source, artifact identity, environment configuration, and reconciliation.

## Review

Open:

```text
../../manifests/chapter09/gitops-application.yaml
../../charts/cloudshop-service/
```

Identify:

- the Git repository and path used as desired state
- the target revision
- the destination cluster and namespace
- chart values that should vary by environment

## Design Questions

- Who can change production desired state?
- What evidence ties an image tag or digest to a build?
- When does rollback stop being safe?
- Which differences belong in values, and which belong in code?

