# merge-yaml

Deep-merge two YAML files, with the second file's values taking precedence over the first. Optionally annotates changed values with a comment.

## Usage

```
merge-yaml FILE1 FILE2 [OUTPUT_FILE] [--comment COMMENT]
```

## Arguments

| Argument | Description |
|----------|-------------|
| `FILE1` | Base/default values YAML file (required) |
| `FILE2` | Override values YAML file (required) |
| `OUTPUT_FILE` | Output file path (default: `merged-yaml.yaml`) |

## Options

| Flag | Description |
|------|-------------|
| `--comment TEXT` | Comment string to annotate changed lines in the output |

## Examples

```bash
# Merge two YAML files
merge-yaml defaults.yaml overrides.yaml

# Write to a specific output file
merge-yaml defaults.yaml overrides.yaml merged.yaml

# Annotate changed values with a comment
merge-yaml defaults.yaml overrides.yaml --comment "overridden"
```

## Notes

- Performs a recursive deep merge: nested dictionaries are merged, not replaced
- `FILE2` values take precedence over `FILE1` values
- When `--comment` is specified, uses `yq` to diff and annotate changed lines

## Requirements

- `PyYAML` Python package (installed via `make install`)
- `yq` (when using `--comment`)
