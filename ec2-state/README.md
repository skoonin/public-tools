# ec2-state

View and manage EC2 instance state across AWS regions. Supports stopping, starting, and terminating instances by ID, with automatic region discovery.

## Usage

```
ec2-state -p PROFILE -i INSTANCE_IDS [options]
```

## Options

| Flag | Description |
|------|-------------|
| `-p, --profile` | AWS profile (required) |
| `-i, --instances` | Comma-separated instance IDs (required) |
| `--region` | Specific region (auto-discovers all regions if omitted) |
| `-s, --stop` | Stop instances |
| `-r, --run` | Start instances |
| `-t, --terminate` | Terminate instances |

## Examples

```bash
# View current state of instances (auto-discovers region)
ec2-state -p my-profile -i i-0abc123,i-0def456

# Stop instances
ec2-state -p my-profile -i i-0abc123 --stop

# Start instances in a specific region
ec2-state -p my-profile -i i-0abc123 --region us-east-2 --run

# Terminate instances
ec2-state -p my-profile -i i-0abc123 --terminate
```

## Notes

- Region discovery runs concurrently across all AWS regions (5 workers)
- State is refreshed and displayed after terminate actions

## Requirements

- AWS CLI configured with appropriate credentials
- IAM permissions: `ec2:DescribeInstances`, `ec2:StartInstances`, `ec2:StopInstances`, `ec2:TerminateInstances`
