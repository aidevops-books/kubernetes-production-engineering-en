# Lab 5: Storage and Recovery

This lab supports Chapter 5.

## Goal

Separate Kubernetes storage mechanics from business data recovery.

## Review

Open:

```text
../../manifests/chapter05/cloudshop-storage-recovery.yaml
```

Identify:

- the PVC boundary created by the StatefulSet's `volumeClaimTemplates`
- StatefulSet identity and volume relationship
- the headless Service
- the scheduled recovery check hook

## Design Questions

- Is this data authoritative, rebuildable, or temporary?
- What RPO and RTO apply?
- Who owns backup and restore verification?
- What provider-specific snapshot or database backup system would replace the placeholder job?

