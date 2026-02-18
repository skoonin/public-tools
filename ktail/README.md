# ktail

Tail Kubernetes pod logs with filtering, multi-pod support, and colored output. Streams logs from all matching pods simultaneously and filters by include/exclude patterns.

## Usage

```
ktail [OPTIONS]
```

## Options

### Targeting

| Flag | Description |
|------|-------------|
| `-c, --context PATTERN` | Kubernetes context (supports pattern matching) |
| `-cx, --exclude-context PAT` | Exclude contexts matching pattern |
| `-n, --namespace NS` | Kubernetes namespace |
| `-N, --exclude-namespace NS` | Exclude namespaces matching pattern |
| `-A, --all-namespaces` | Search all namespaces |
| `-d, --deployment NAME` | Deployment name or pattern |
| `-p, --pod PATTERN` | Pod name regex pattern |
| `-l, --label SELECTOR` | Label selector (e.g., `app=myapp`) |
| `-x, --container NAME` | Specific container name |

### Filtering

| Flag | Description |
|------|-------------|
| `-i, --include PATTERN` | Regex to include lines (default: `error\|failure\|backoff\|unable`) |
| `-e, --exclude PATTERN` | Regex to exclude lines (default: `walk\|routine\|scheduled`) |

### Output

| Flag | Description |
|------|-------------|
| `-f, --follow` | Stream logs continuously (default: true) |
| `-s, --since DURATION` | Show logs since duration (default: `5m`) |
| `-t, --tail N` | Lines per pod (default: 10) |
| `--timestamps` | Show timestamps |
| `--no-color` | Disable colored output |
| `-q, --quiet` | Suppress pod headers |
| `-o, --output FORMAT` | Format: `default`, `raw`, or `json` |
| `-1, --single-container` | Only show first container |

## Examples

```bash
# Tail error logs from all pods in a deployment
ktail -d my-deployment -n my-namespace

# Follow all logs from pods matching a pattern (no filter)
ktail -p "worker-.*" -i ".*"

# Show logs with timestamps from specific context
ktail -c prod-cluster -n kube-system --timestamps

# JSON output for piping to jq
ktail -o json | jq .
```

## Notes

- Pod names are consistently color-coded across output lines for readability
- Streams from multiple pods run in parallel

## Requirements

- `kubectl` configured with appropriate contexts
