{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "todos.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "todos.serviceAccountName" -}}
{{- .Values.todos.serviceAccount.name }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "todos.webui.name" -}}
{{- .Values.todos.webui.name | trunc 63 }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "todos.webui.labels" -}}
helm.sh/chart: {{ include "todos.chart" . }}
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
Expand the name of the chart.
*/}}
{{- define "todos.mysql.name" -}}
{{- .Values.todos.mysql.name | trunc 63 }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "todos.mysql.labels" -}}
helm.sh/chart: {{ include "todos.chart" . }}
{{ include "todos.mysql.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "todos.mysql.selectorLabels" -}}
app.kubernetes.io/name: {{ include "todos.mysql.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}