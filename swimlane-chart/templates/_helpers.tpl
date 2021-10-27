{{/* Generate basic labels */}}
{{- define "swimlane.labels" }}
    app.kubernetes.io/component: web
    app.kubernetes.io/name: swimlane
    app: swimlane-node
    chart: {{ .Chart.Name }}
    version: {{ .Chart.Version }}
{{- end }}