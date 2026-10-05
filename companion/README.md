# Kubernetes Production Engineering CloudShop Companion

This repository contains optional lab material for *Kubernetes Production Engineering*.

**Official companion page:** [aidevops.kr/books/kubernetes-production-engineering](https://aidevops.kr/books/kubernetes-production-engineering) — every path the book references (`companion/manifests/...`, `companion/labs/...`, `companion/charts/...`) is published there for re-download if you no longer have this checkout.

The examples are intentionally small. They are not a complete production platform. Their purpose is to make the book's architecture contracts visible as Kubernetes objects that can be reviewed, validated, and adapted.

## Scope

- Chapter 1: first Kubernetes deployment shape
- Chapter 2: workload contract, configuration, service, probes, shutdown
- Chapter 3: resource requests, disruption, placement, priority, and autoscaling
- Chapter 4: Gateway API, route ownership, Services, and NetworkPolicy
- Chapter 5: PVCs, StatefulSet identity, and backup/recovery hooks
- Chapter 6: Pod Security, RBAC, service accounts, and runtime hardening
- Chapter 7: telemetry configuration, scrape hints, and SLO policy examples
- Chapter 8: troubleshooting scenario manifests
- Chapter 9: GitOps layout, Argo CD example, and a small Helm chart
- Chapter 10: enterprise namespace, quota, governance, and readiness baseline

The examples stay provider-neutral unless a chapter is explicitly discussing provider integration patterns.

## Repository Layout

```text
manifests/
  kustomization.yaml   # deploys the steady-state stack: chapters 02, 04-07, 09, 10
  chapter01/
  chapter02/
  chapter03/
  chapter04/
  chapter05/
  chapter06/
  chapter07/
  chapter08/
  chapter09/
  chapter10/
labs/
  ch01-container-to-k8s/
  ch02-workloads/
  ch03-cluster-design/
  ch04-networking/
  ch05-storage-recovery/
  ch06-security/
  ch07-observability/
  ch08-troubleshooting/
  ch09-delivery-gitops/
  ch10-enterprise-architecture/
scripts/
  validate.ps1
  validate.sh
```

## Requirements

- Kubernetes 1.35 or later recommended
- `kubectl`
- Optional local cluster: kind, minikube, Docker Desktop Kubernetes, or a managed development cluster

These examples use placeholder images under `example.invalid`. Replace them with real images before deploying.

## Validation

Validate manifests without applying them:

```bash
sh ./scripts/validate.sh
```

PowerShell:

```powershell
./scripts/validate.ps1
```

By default, validation is offline-friendly and runs `kubectl kustomize` against each chapter directory. This checks that the YAML can be loaded and rendered without requiring a Kubernetes API server.

To run stricter client dry-run validation against a reachable cluster:

```bash
sh ./scripts/validate.sh --strict
```

PowerShell:

```powershell
./scripts/validate.ps1 -Strict
```

Offline rendering catches YAML and kustomization loading errors. If Helm is installed, the validation script also renders the sample chart. Strict validation catches more API-shape issues, but it still does not prove that a design is production-ready.

## Using With the Book

Read the chapter first, then inspect the matching manifest and lab directories.

The book explains why a production contract exists. The manifests show one possible implementation of that contract.

## Deploying the Whole Stack at Once

Chapters 1-3 are three narrative snapshots of the same `product-service` Deployment (bare Deployment -> full workload contract -> +PriorityClass/topology spread/PDB/HPA). Reading them in order and running each chapter's `kubectl apply -k` in turn works fine, since each apply just updates the same live object -- but `kustomize build` can't statically combine all three into one manifest, because two of them would define the identical `Deployment/product-service` object.

For that reason, `companion/manifests/kustomization.yaml` deploys the steady-state stack in one pass without chapter01/ or chapter03/:

```bash
kubectl apply -k companion/manifests/
```

This brings up chapters 02, 04, 05, 06, 07, 09, and 10 across their six namespaces plus the `argocd`-scoped `Application` from chapter 9 -- 39 objects with no naming conflicts, verified with `kubectl kustomize companion/manifests/`. chapter01/ and chapter03/ remain fully usable on their own (`kubectl apply -k companion/manifests/chapter01/`, etc.) while you're working through those specific chapters.

chapter08/ (`troubleshooting-scenarios.yaml`) is excluded on purpose -- it's five Pods deliberately built to fail (Pending, ImagePullBackOff, CrashLoopBackOff, OOMKilled, a bad readiness probe), not something you want sitting in the cluster you just brought up cleanly. Apply it separately, as its own optional overlay, when you get to Chapter 8:

```bash
kubectl apply -k companion/manifests/chapter08/
```

Two things the stack assumes are already on the cluster: a Gateway API implementation (for chapter04/'s `Gateway`/`HTTPRoute`) and Argo CD with its CRDs (for chapter09/'s `Application`). Without them, `kubectl kustomize` still renders fine -- only the live `kubectl apply` of those specific objects will fail until the platform pieces are installed.

## Important Limits

Some examples reference optional APIs such as Gateway API, Prometheus Operator, Argo CD, and provider-specific workload identity annotations. `kubectl kustomize` can render these examples offline, but strict API validation requires the matching CRDs or platform features to be installed in the target cluster.
