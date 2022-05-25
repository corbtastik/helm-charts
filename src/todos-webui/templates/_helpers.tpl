{{/*
Expand the name of the chart.
*/}}
{{- define "todos.webui.name" -}}
{{- .Values.todos.webui.name | trunc 63 }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "todos.webui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "todos.webui.labels" -}}
helm.sh/chart: {{ include "todos.webui.chart" . }}
{{ include "todos.webui.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "todos.webui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "todos.webui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "todos.serviceAccountName" -}}
{{- .Values.todos.serviceAccount.name }}
{{- end }}
