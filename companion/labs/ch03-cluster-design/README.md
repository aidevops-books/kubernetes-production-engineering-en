# Lab 3: Cluster Design Controls

This lab supports Chapter 3.

## Goal

Connect production requirements to scheduling, disruption, resource, and autoscaling controls.

## Review

Open:

```text
../../manifests/chapter03/product-service-production-controls.yaml
```

Identify:

- minimum serving capacity
- rollout surge behavior
- memory request and limit
- zone and node topology policy
- voluntary disruption policy
- CPU-based HPA behavior
- scale-up and scale-down stabilization

## Design Questions

- What happens if only one zone has available capacity?
- Is `ScheduleAnyway` acceptable for zone spread?
- Should CPU be the scaling signal for this service?
- Can the cluster fit a rolling update during a node failure?

## Optional Dry Run

```bash
kubectl apply --dry-run=client -f ../../manifests/chapter03/product-service-production-controls.yaml
```

