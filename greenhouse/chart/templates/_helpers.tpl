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

{{- define "redfish-exporter.labels" -}}
app.kubernetes.io/name: {{ include "redfish-exporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: Helm
chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}

{{- define "redfish-exporter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "redfish-exporter.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{- define "redfish-operations.additionalRuleLabels" -}}
{{- with .Values.prometheusRules.additionalRuleLabels }}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{- define "redfish-operations.ruleSelectorLabels" -}}
{{- $root := index . 1 -}}
{{- with $root.Values.prometheusRules.ruleSelectors }}
{{- range $i, $target := . }}
{{ $target.name | required (printf "$.Values.prometheusRules.ruleSelectors[%v].name missing" $i) }}: {{ tpl ($target.value | required (printf "$.Values.prometheusRules.ruleSelectors[%v].value missing" $i)) $root }}
{{- end }}
{{- end }}
{{- end -}}
