apiVersion: apps/v1
kind: Deployment
metadata:
  name: xray
  labels:
    app: xray
spec:
  replicas: {{ .Values.replicas.xray }}
  selector:
    matchLabels:
      app: xray
  template:
    metadata:
      labels:
        app: xray
    spec:
      containers:
        - name: xray
          image: xray:local
          command: ["xray"]
          args: ["-config", "/etc/xray/config.json"]
          ports:
            - containerPort: {{ .Values.xray.listenPort }}
          volumeMounts:
            - name: xray-config
              mountPath: /etc/xray/config.json
              subPath: config.json
      volumes:
        - name: xray-config
          configMap:
            name: xray-config
