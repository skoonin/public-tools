# ktx

Fuzzy search and switch Kubernetes contexts and namespaces. Displays a numbered menu when multiple contexts match.

## Usage

```
ktx [SEARCH] [FILTER] [-n NAMESPACE]
```

## Arguments

| Argument | Description |
|----------|-------------|
| `SEARCH` | Search term to match context names |
| `FILTER` | Optional second term to narrow matches |

## Options

| Flag | Description |
|------|-------------|
| `-n NAMESPACE` | Switch to this namespace after selecting context |

## Examples

```bash
# Switch to a context matching "prod"
ktx prod

# Narrow down with a second filter
ktx prod us-east

# Switch context and set namespace
ktx staging -n my-namespace
```

## Notes

- If one context matches, switches immediately
- If multiple contexts match, shows a numbered menu for selection

## Requirements

- `kubectx` and `kubens` installed and in PATH
