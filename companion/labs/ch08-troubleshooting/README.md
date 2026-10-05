# Lab 8: Troubleshooting Scenarios

This lab supports Chapter 8.

## Goal

Use intentionally flawed manifests to practice symptom-driven troubleshooting.

## Review

Open:

```text
../../manifests/chapter08/troubleshooting-scenarios.yaml
```

Scenarios:

- Pending Pod from impossible placement
- ImagePullBackOff from an invalid image
- readiness failure from an incorrect probe path
- CrashLoopBackOff from a container that exits immediately on startup
- OOMKilled from a container that exceeds its memory limit

## Practice

For each scenario, write the expected investigation path before running commands:

- owning resource
- desired state
- observed state
- events
- next controller or runtime boundary
- likely mitigation
- prevention

