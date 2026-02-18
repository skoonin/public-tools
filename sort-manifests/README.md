# sort-manifests

Sort Kubernetes manifest files by resource kind and name. Writes sorted output to new files with a `-sorted` suffix.

## Usage

```
sort-manifests FILE1.yaml [FILE2.yaml ...]
```

## Arguments

| Argument | Description |
|----------|-------------|
| `FILE` | One or more YAML manifest files to sort (required) |

## Example

```bash
# Sort a single manifest
sort-manifests k8s/resources.yaml
# Output: k8s/resources-sorted.yaml

# Sort multiple files
sort-manifests deploy.yaml service.yaml configmap.yaml
```

## Notes

- Sorts resources by `(kind, metadata.name)` tuple
- Creates new files with `-sorted` suffix; does not modify the originals
- Handles multi-document YAML files (separated by `---`)

## Requirements

- `PyYAML` Python package (installed via `make install`)
