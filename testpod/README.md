# testpod

Deploy a [netshoot](https://github.com/nicolaka/netshoot) debug pod into a Kubernetes cluster for network troubleshooting. Supports interactive shell access and easy cleanup.

## Usage

```
testpod [OPTIONS]
```

## Options

| Flag | Description |
|------|-------------|
| `-n, --name NAME` | Pod name (default: `netshoot-test-pod`) |
| `-ns, --namespace NS` | Target namespace |
| `-c, --context CTX` | Target Kubernetes context |
| `-d, --delete` | Delete the pod instead of creating it |
| `-s, --shell` | Start an interactive bash shell after the pod is ready |

## Examples

```bash
# Deploy a debug pod in the current context/namespace
testpod

# Deploy in a specific namespace and context
testpod -ns my-namespace -c prod-cluster

# Deploy and immediately shell into it
testpod -ns my-namespace -s

# Delete the pod
testpod -ns my-namespace -d
```

## Notes

- Uses the `nicolaka/netshoot` image which includes common network debugging tools
- Pod runs with `sleep infinity` so it stays alive until explicitly deleted

## Requirements

- `kubectl` configured with appropriate contexts
