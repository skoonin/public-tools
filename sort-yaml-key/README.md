# sort-yaml-key

Sort a YAML list by a specified key. Reorders each block so the sort key appears first in every item.

## Usage

```
sort-yaml-key -f FILENAME -k KEY
```

## Options

| Flag | Description |
|------|-------------|
| `-f, --filename` | Path to the YAML file (required) |
| `-k, --key` | Key to sort by (required) |

## Examples

```bash
# Sort a list of services by name
sort-yaml-key -f services.yaml -k name

# Sort deployments by namespace
sort-yaml-key -f deployments.yaml -k namespace
```

## Notes

- Input must be a YAML file containing a list of mappings
- The specified key must exist in every item
- Output is printed to stdout (redirect to file to save)
- The sort key is moved to the first position in each block for readability

## Requirements

- `PyYAML` Python package (installed via `make install`)
