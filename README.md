# Blue Matador Kubernetes Agent

Official Kubernetes deployment for the Blue Matador monitoring agent.

## Overview

The Blue Matador agent runs as a DaemonSet in your Kubernetes cluster, automatically deploying one agent pod per node to collect metrics, monitor cluster health, and send data to Blue Matador for intelligent alerting and anomaly detection.

## Requirements

- **Kubernetes**: Version 1.10 or higher
- **Architecture Support**: AMD64 (Intel/AMD) and ARM64 architectures
- **Cluster Access**: Ability to create ClusterRoles and DaemonSets

## Installation

### Quick Start

1. Visit the [Kubernetes Integration page](https://app.bluematador.com/ur/app#/setup/integrations/kubernetes) in the Blue Matador app to get your pre-configured YAML files:
   - `bluematador-rbac.yaml` - Role-based access control permissions
   - `bluematador-agent.yaml` - DaemonSet configuration with your account credentials

2. Apply the configuration files to your cluster:
   ```bash
   kubectl create -f bluematador-rbac.yaml,bluematador-agent.yaml
   ```

3. Verify the agent pods are running:
   ```bash
   kubectl get pods -n default -l app=bluematador-agent
   ```

### What Gets Deployed

- **DaemonSet**: Ensures one Blue Matador agent pod runs on each node in your cluster
- **Service Account**: Dedicated service account for the agent
- **ClusterRole & ClusterRoleBinding**: Read-only permissions to collect Kubernetes metrics

### Docker Image

The agent uses the official Docker image: `bluematador/agent:latest`

Multi-architecture support is built-in:
- Automatically detects and runs the correct binary for AMD64 or ARM64 nodes
- Works seamlessly across mixed-architecture clusters

## Verification

After installation, verify the agent is working:

1. **Check pod status**:
   ```bash
   kubectl get pods -l app=bluematador-agent
   ```
   All pods should be in `Running` state.

2. **View agent logs**:
   ```bash
   kubectl logs -l app=bluematador-agent --tail=50
   ```

3. **Confirm in Blue Matador**: Your Kubernetes cluster should appear in the Blue Matador dashboard within a few minutes.

## Updating the Agent

The Blue Matador agent automatically updates itself when new versions are released. No manual intervention is required.

To force a restart of all agent pods:
```bash
kubectl rollout restart daemonset/bluematador-agent
```

## Troubleshooting

### Pods not starting
- Verify your account credentials in `bluematador-agent.yaml`
- Check pod logs: `kubectl logs <pod-name>`
- Ensure your cluster has internet access to reach Blue Matador servers

### Permissions errors
- Verify RBAC is properly configured: `kubectl get clusterrole bluematador-agent`
- Ensure the service account is bound: `kubectl get clusterrolebinding bluematador-agent`

### Agent not reporting data
- Check network connectivity from the cluster
- Verify API key is correct in the DaemonSet configuration
- Review pod logs for connection errors

## Uninstalling

To remove the Blue Matador agent from your cluster:
```bash
kubectl delete -f bluematador-agent.yaml,bluematador-rbac.yaml
```

## Support

Need help?
- **Email**: [support@bluematador.com](mailto:support@bluematador.com)
- **Documentation**: [Blue Matador Docs](https://www.bluematador.com/docs)
- **Website**: [www.bluematador.com](https://www.bluematador.com)

## Additional Resources

- [Blue Matador Documentation](https://www.bluematador.com/docs)
- [Kubernetes Monitoring Best Practices](https://www.bluematador.com/blog)
- [Example Deployments](./examples/) - Sample workloads for testing the agent
