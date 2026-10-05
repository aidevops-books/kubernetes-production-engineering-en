# Lab 7: Observability and Reliability

This lab supports Chapter 7.

## Goal

Connect telemetry configuration to service reliability questions.

## Review

Open:

```text
../../manifests/chapter07/cloudshop-observability.yaml
```

Identify:

- service ownership and SLO policy
- metrics scrape hints
- OpenTelemetry service name
- OTLP collector endpoint

## Design Questions

- Which SLI reflects user experience?
- Which alert is actionable?
- What evidence distinguishes application latency from dependency latency?
- What happens when telemetry infrastructure is unavailable?

