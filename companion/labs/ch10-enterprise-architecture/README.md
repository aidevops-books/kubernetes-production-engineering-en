# Lab 10: Enterprise Production Baseline

This lab supports Chapter 10.

## Goal

Review the platform controls that make production behavior repeatable across teams.

## Review

Open:

```text
../../manifests/chapter10/enterprise-baseline.yaml
```

Identify:

- production namespace ownership
- Pod Security enforcement
- ResourceQuota
- LimitRange defaults and maximums
- readiness baseline checklist

## Design Questions

- Which controls are enforced automatically?
- Which controls are reviewed manually?
- Which controls are provider-specific?
- What evidence proves the platform is ready for Day 2 operations?

