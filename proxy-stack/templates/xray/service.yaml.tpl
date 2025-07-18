apiVersion: v1
kind: Service
metadata:
  name: xray-service
spec:
  selector:
    app: xray
  ports:
    - protocol: TCP
      port: {{ .Values.xray.listenPort }}         # exposed port (inside cluster)
      targetPort: {{ .Values.xray.listenPort }}   # port inside pod
  type: NodePort        # expose to outside (for Minikube)
