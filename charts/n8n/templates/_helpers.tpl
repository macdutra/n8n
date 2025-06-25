{{/*
Expand the name of the chart.
*/}}
{{- define "n8n.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "n8n.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "n8n.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "n8n.labels" -}}
helm.sh/chart: {{ include "n8n.chart" . }}
{{ include "n8n.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "n8n.selectorLabels" -}}
app.kubernetes.io/name: {{ include "n8n.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
PostgreSQL fullname
*/}}
{{- define "n8n.postgresql.fullname" -}}
{{- printf "%s-postgresql" (include "n8n.fullname" .) -}}
{{- end }}

{{/*
Redis fullname
*/}}
{{- define "n8n.redis.fullname" -}}
{{- printf "%s-redis" (include "n8n.fullname" .) -}}
{{- end }}

{{/*
Get the database password secret name
*/}}
{{- define "n8n.database.secretName" -}}
{{- if .Values.n8n.secrets.database.passwordSecretName }}
{{- .Values.n8n.secrets.database.passwordSecretName }}
{{- else }}
{{- printf "%s-secret" (include "n8n.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Get the Redis password secret name
*/}}
{{- define "n8n.redis.secretName" -}}
{{- if .Values.n8n.secrets.redis.passwordSecretName }}
{{- .Values.n8n.secrets.redis.passwordSecretName }}
{{- else }}
{{- printf "%s-secret" (include "n8n.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Get the basic auth secret name
*/}}
{{- define "n8n.basicAuth.secretName" -}}
{{- if .Values.n8n.secrets.basicAuth.passwordSecretName }}
{{- .Values.n8n.secrets.basicAuth.passwordSecretName }}
{{- else }}
{{- printf "%s-secret" (include "n8n.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Get the encryption key secret name
*/}}
{{- define "n8n.encryption.secretName" -}}
{{- if .Values.n8n.secrets.encryption.keySecretName }}
{{- .Values.n8n.secrets.encryption.keySecretName }}
{{- else }}
{{- printf "%s-secret" (include "n8n.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "n8n.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "n8n.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}