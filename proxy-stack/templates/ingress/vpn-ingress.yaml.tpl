apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: vpn-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  tls:
  - hosts:
    - "{{ .Values.ingress.host }}"
    secretName: vpn-domain-tls-secret
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
