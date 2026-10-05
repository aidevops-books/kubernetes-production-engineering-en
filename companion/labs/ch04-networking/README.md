# Lab 4: Networking and Traffic Management

This lab supports Chapter 4.

## Goal

Connect request paths, route ownership, and east-west reachability to Kubernetes objects.

## Review

Open:

```text
../../manifests/chapter04/cloudshop-network.yaml
```

Identify:

- the public Gateway listener
- separate HTTPRoutes owned per team: `order-routes` (`/api/orders`), `product-routes` (`/api/products`), `frontend-routes` (`/`)
- internal Services
- default-deny ingress policy
- explicitly allowed service-to-service traffic

## Design Questions

- Which team owns the Gateway?
- Which team owns each HTTPRoute?
- What evidence proves that a route has attached successfully?
- Which NetworkPolicy tests should prove that forbidden flows fail?

