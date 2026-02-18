# tfdel

Recursively delete `.terraform` directories and `.terraform.lock.hcl` files. Useful for cleaning up Terraform state caches before a fresh init.

## Usage

```
tfdel [PATH]
```

## Arguments

| Argument | Description |
|----------|-------------|
| `PATH` | Directory to search recursively (default: current directory) |

## Examples

```bash
# Clean current directory
tfdel

# Clean a specific path
tfdel ~/infra/terraform
```

## Output

Reports each deleted item and the total disk space reclaimed (in MB, GB, or TB).

## Requirements

No external dependencies beyond Python standard library.
