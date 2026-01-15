{{- define "redfish-exporter.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end -}}

{{- define "redfish-exporter.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "redfish-exporter.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/* Generate basic labels */}}
{{- define "kvm-operations.labels" -}}
{{- $root := index . 1 -}}
app.cloud-storage.io/version: {{ $root.Chart.Version }}
app.cloud-storage.io/part-of: {{ $root.Release.Name }}
{{- with $root.Values.global.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{- define "kvm-operations.additionalRuleLabels" -}}
{{- with .Values.prometheusRules.additionalRuleLabels }}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{- define "redfish-exporter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "redfish-exporter.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{- define "kvm-operations.ruleSelectorLabels" -}}
{{- $root := index . 1 -}}
{{- with $root.Values.prometheusRules.ruleSelectors }}
{{- range $i, $target := . }}
{{ $target.name | required (printf "$.Values.prometheusRules.ruleSelectors[%v].name missing" $i) }}: {{ tpl ($target.value | required (printf "$.Values.prometheusRules.ruleSelectors[%v].value missing" $i)) $root }}
{{- end }}
{{- end }}
{{- end -}}
