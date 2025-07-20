apiVersion: v1
kind: Secret
metadata:
  name: vpn-domain-tls-secret
type: kubernetes.io/tls
data:
  tls.crt: {{ .Files.Get .Values.ingress.tls.crtFile | b64enc | quote }}
  tls.key: {{ .Files.Get .Values.ingress.tls.keyFile | b64enc | quote }}