# aws-secret-replication-check

Check replication status of AWS Secrets Manager secrets across regions. Displays all secrets and their replication state in a formatted table.

## Usage

```
aws-secret-replication-check check-replication -r REGION -p PROFILE
```

## Options

| Flag | Description |
|------|-------------|
| `-r, --region` | AWS region to query (required) |
| `-p, --profile` | AWS profile to use (required) |

## Example

```bash
aws-secret-replication-check check-replication -r us-east-2 -p my-aws-profile
```

## Output

Tabular output showing secret name and replication status for each secret in the region.

## Requirements

- AWS CLI configured with appropriate credentials
- `boto3`, `typer`, `tabulate` Python packages (installed via `make install`)
- IAM permission: `secretsmanager:ListSecrets`
