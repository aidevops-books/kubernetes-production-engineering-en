# Version Notes

These examples were drafted for the manuscript's pre-verification phase.

Target baseline: **Kubernetes 1.35+**. At time of writing, 1.35 / 1.36 / 1.37 are the currently
maintained minor releases (1.37.0 shipped 2026-08-26); 1.35 is used as the book's floor so
examples keep working across the whole supported window, not just the newest release.

Recommended verification targets:

- Kubernetes: 1.35+
- HorizontalPodAutoscaler API: `autoscaling/v2`
- PodDisruptionBudget API: `policy/v1`
- Deployment / StatefulSet API: `apps/v1`
- Service / Namespace / ConfigMap / Secret / ServiceAccount / PersistentVolumeClaim API: `v1`
- NetworkPolicy API: `networking.k8s.io/v1`
- Gateway API (Gateway, HTTPRoute): `gateway.networking.k8s.io/v1`
- RBAC (Role, RoleBinding): `rbac.authorization.k8s.io/v1`
- Argo CD Application: `argoproj.io/v1alpha1` (project-defined, not a Kubernetes core API)

Audited against the 1.30-1.35 deprecation/removal history; nothing in the companion manifests
or manuscript uses an API this range touches. Two node-level platform changes are worth knowing
about even though no example needed a code change for them:

- **cgroup v1 is gone as of 1.35** (not merely deprecated) — kubelet will not start on a cgroup
  v1 host by default. Chapter 8's CPU-throttling section (`/sys/fs/cgroup/cpu.stat`,
  `container_cpu_cfs_*` metrics) already assumes the cgroup v2 unified hierarchy, so it needed
  no change; a pre-1.35 draft written against cgroup v1 paths would not have.
- **`ipvs` kube-proxy mode is deprecated in 1.35** in favor of `nftables` (stable since 1.33).
  The book never asserts a specific kube-proxy mode, so this doesn't touch any example, but
  don't demo `ipvs` as the forward-looking choice if you extend this material.

Before publication, verify each manifest against the supported Kubernetes versions named in the book.

Provider-specific behavior is intentionally avoided in Chapters 1-3. Node pools, topology labels, metrics availability, and autoscaler behavior vary by provider and cluster configuration.

