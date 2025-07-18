apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: vpn-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    cert-manager.io/cluster-issuer: {{ if .Values.certManager.selfSigned }}selfsigned{{ else }}letsencrypt-staging{{ end }}
spec:
  tls:
  - hosts:
    - "{{ .Values.ingress.host }}"
    secretName: vpn-domain-tls
  rules:
    - host: "{{ .Values.ingress.host }}"
      http:
        paths:
          - path: {{ .Values.ingress.vpnPath }}
            pathType: Prefix
            backend:
              service:
                name: xray-service
                port:
                  number: {{ .Values.xray.listenPort }}
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginx-service
                port:
                  number: 8080
