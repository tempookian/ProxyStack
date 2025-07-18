# ProxyStack

A comprehensive Helm chart for deploying VPN and gateway tools on Kubernetes with automatic SSL certificate management and ingress configuration.

## Overview

ProxyStack provides a production-ready Kubernetes deployment solution for proxy and VPN services. It includes automatic SSL certificate management, ingress configuration, and scalable deployments for various proxy tools.

## Features

- **Multi-Component Architecture**: Support for multiple proxy and VPN components
- **Automatic SSL/TLS**: Integrated certificate management with cert-manager
- **Ingress Configuration**: Flexible ingress setup with path-based routing
- **Scalable Deployments**: Configurable replica counts for high availability
- **Helm-Based**: Easy deployment and configuration management
- **Production Ready**: Includes proper service definitions and resource management

## Currently Supported Components

### Xray
- High-performance proxy server
- Configurable client authentication
- Customizable logging levels
- Internal cluster communication

### Nginx
- Web server and reverse proxy
- Static content serving
- Load balancing capabilities
- Stable and reliable deployment

## Prerequisites

- Kubernetes cluster (1.19+)
- Helm 3.x
- cert-manager (for SSL certificate management)
- NGINX Ingress Controller

## Installation

### 1. Add the Helm Repository

```bash
helm repo add proxy-stack https://your-helm-repo-url
helm repo update
```

### 2. Create a Values File

Copy the example values file and customize it for your environment:

```bash
cp proxy-stack/values.yaml.example my-values.yaml
```

### 3. Deploy ProxyStack

```bash
helm install proxy-stack ./proxy-stack -f my-values.yaml
```

## Configuration

### Basic Configuration

The main configuration options are defined in `values.yaml`:

```yaml
certManager:
  email: "your-email@example.com"
  selfSigned: true  # Set to false for Let's Encrypt

ingress:
  className: nginx
  host: "your-domain.com"
  vpnPath: "/api01"

replicas:
  xray: 1
  nginx: 1
```

### Component-Specific Configuration

#### Xray Configuration

```yaml
xray:
  listenPort: 10801
  logLevel: "debug"
  client:
    email: "client@example.com"
    id: "your-client-id"
```

#### Nginx Configuration

Nginx uses the stable image with default configuration. Custom configurations can be added through ConfigMaps.

### SSL Certificate Management

ProxyStack supports two certificate management modes:

1. **Self-Signed Certificates** (default):
   ```yaml
   certManager:
     selfSigned: true
   ```

2. **Let's Encrypt Certificates**:
   ```yaml
   certManager:
     selfSigned: false
     email: "your-email@example.com"
   ```

## Architecture

```
Internet
    │
    ▼
┌─────────────┐
│   Ingress   │ ← NGINX Ingress Controller
│  Controller │
└─────────────┘
    │
    ├── /api01 → Xray Service
    └── /      → Nginx Service
```

## Usage

### Accessing Services

- **Web Content**: `https://your-domain.com/`
- **VPN/Proxy**: `https://your-domain.com/api01`

### Scaling

To scale components, update the replica counts in your values file:

```yaml
replicas:
  xray: 3
  nginx: 2
```

Then upgrade the deployment:

```bash
helm upgrade proxy-stack ./proxy-stack -f my-values.yaml
```

## Development

### Local Development with Skaffold

This project includes Skaffold configuration for local development:

```bash
skaffold dev
```

### Building Custom Images

Custom Docker images can be built using the provided Dockerfiles in the `docker/` directory.

## Troubleshooting

### Common Issues

1. **Certificate Issues**: Ensure cert-manager is properly installed and configured
2. **Ingress Not Working**: Verify NGINX Ingress Controller is deployed
3. **Service Connectivity**: Check service selectors and port configurations

### Logs

View component logs:

```bash
# Xray logs
kubectl logs -l app=xray

# Nginx logs
kubectl logs -l app=nginx
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

TBDp

## Support

For support and questions:
- Create an issue in the GitHub repository
- Contact: tempookian@gmail.com

## Roadmap

- [ ] Support for additional proxy tools
- [ ] Enhanced monitoring and metrics
- [ ] Multi-cluster deployment support
- [ ] Advanced load balancing configurations
- [ ] Custom authentication mechanisms
