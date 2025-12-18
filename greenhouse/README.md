---
title: Redfish Exporter Greenhouse Plugin
---

This is a Greenhouse plugin package for the `redfish-exporter` Prometheus exporter. It provides a minimal set of plugin metadata and Helm chart values to deploy the exporter in a Greenhouse-managed cluster.

Quick start

Install the chart using Helm (example):

```bash
helm install redfish-exporter ./chart
```

Configuration

The plugin exposes a few common options such as `serviceMonitorLabels`, Prometheus rules and dashboard toggles. See `plugindefinition.yaml` for the full list of available options.

Examples

Install the plugin as a `Plugin` resource in the cluster:

```yaml
apiVersion: greenhouse.sap/v1alpha1
kind: Plugin
metadata:
  name: redfish-exporter
spec:
  pluginDefinition: redfish-exporter
  disabled: false
  optionValues:
    - key: serviceMonitorLabels
      value: {}
```
