apiVersion: v1
kind: ConfigMap
metadata:
  name: xray-config
data:
  config.json: |-
    {
      "log": {
        "loglevel": "{{ .Values.xray.logLevel }}"
      },
      "inbounds": [
        {
          "listen": "0.0.0.0",
          "port": {{ .Values.xray.listenPort }},
          "protocol": "vmess",
          "streamSettings": {
            "network": "ws",
            "wsSettings": {
              "path": "/"
            }
          },
          "settings": {
            "clients": [
              {
                "email": "{{ .Values.xray.client.email }}",
                "id": "{{ .Values.xray.client.id }}",
                "level": 1,
                "alterId": 0
              }
            ]
          }
        }
      ],
      "outbounds": [
        {
          "protocol": "freedom",
          "tag": "direct"
        }
      ],
      "routing": {
        "domainStrategy": "IPIfNonMatch"
      }
    }
