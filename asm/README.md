# asm

AWS Secrets Manager CLI for getting, creating, updating, deleting, and searching secrets. Supports key/value pairs, files, TLS certificates, and binary data.

## Usage

```
asm <command> [options]
```

## Commands

| Command | Description |
|---------|-------------|
| `get <name>` | Retrieve a secret value |
| `create <name>` | Create a new secret |
| `update <name>` | Update an existing secret |
| `delete <name>` | Delete a secret |
| `search [pattern]` | Search secrets by regex pattern |
| `list` | List all secrets (alias for `search` with no pattern) |

## Options

| Flag | Description |
|------|-------------|
| `-p, --profile` | AWS profile |
| `--region` | AWS region |
| `-v, --value KEY=VAL` | Key=value pair (repeatable) |
| `-f, --file PATH` | Import value from file |
| `-b, --binary` | Treat file content as binary (base64-encode) |
| `-C, --tls-crt PATH` | TLS certificate file |
| `-K, --tls-key PATH` | TLS private key file |
| `--no-key` | Store raw TLS content without key wrapper |
| `-D, --description TEXT` | Secret description |
| `-k, --kms-key ID` | KMS key ID for encryption |
| `-t, --tags KEY=VAL` | Tags in key=value format (repeatable) |
| `-r, --dry-run` | Preview changes without applying |
| `--force` | Force update even if value is unchanged |
| `--arn` | Return ARN only (with `get`) |
| `-R, --recovery N` | Recovery window in days for delete (7-30) |

## Examples

```bash
# Get a secret value
asm get myapp/prod/api-key

# Get ARN only
asm get myapp/prod/api-key --arn

# Create a secret with key/value pairs
asm create myapp/prod/config -v username=admin -v port=5432

# Create a secret from a file
asm create myapp/prod/cert -C server.crt -K server.key

# Update a secret
asm update myapp/prod/config -v username=newuser

# Delete with a 14-day recovery window
asm delete myapp/prod/old-key -R 14

# Search for secrets matching a pattern
asm search "myapp/prod/.*"

# List all secrets
asm list
```

## Requirements

- AWS CLI configured with appropriate credentials
- `boto3` Python package (installed via `make install`)
- IAM permissions for `secretsmanager:*` on target secrets
