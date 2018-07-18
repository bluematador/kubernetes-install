# Examples

Example specs for Kubernetes resources that can be used to test certain conditions that the Blue Matador agent will catch.

## Requirements

 * Blue Matador agent already installed in your cluster

## Usage

Bad Image
```
kubectl apply -f https://raw.githubusercontent.com/bluematador/kubernetes-install/master/examples/bad_image_deployment.yaml
```

Out of Memory
```
kubectl apply -f https://raw.githubusercontent.com/bluematador/kubernetes-install/master/examples/oom_deployment.yaml
```

High Resource Requirements
```
kubectl apply -f https://raw.githubusercontent.com/bluematador/kubernetes-install/master/examples/high_resources_deployment.yaml
```

Service with Bad Endpoints
```
kubectl apply -f https://raw.githubusercontent.com/bluematador/kubernetes-install/master/examples/echo_server_deployment.yaml
kubectl apply -f https://raw.githubusercontent.com/bluematador/kubernetes-install/master/examples/echo_server_service.yaml
```

## Additional Information

For more information, visit the [Blue Matador Website](https://www.bluematador.com)
