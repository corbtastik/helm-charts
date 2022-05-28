{{/* Name and version of todos-webui Helm Chart */}}
{{- define "todos.webui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Name of todos-webui Service Account */}}
{{- define "todos.webui.serviceAccountName" -}}
{{- .Values.todos.webui.serviceAccount.name }}
{{- end }}

{{/* Name of todos-webui application. */}}
{{- define "todos.webui.name" -}}
{{- .Values.todos.webui.name | trunc 63 }}
{{- end }}

{{/* All labels for todos-webui, includes selector labels */}}
{{- define "todos.webui.labels" -}}
helm.sh/chart: {{ include "todos.webui.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "todos.webui.selectorLabels" . }}
{{- end }}

{{/* Selector labels for todos-webui, long and short app & version labels */}}
{{- define "todos.webui.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "todos.webui.name" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app: {{ include "todos.webui.name" . }}
version: {{ .Chart.AppVersion }}
{{- end }}