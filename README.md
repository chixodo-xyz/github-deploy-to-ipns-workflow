# Github Deploy to IPNS Workflow

[![Deploy to IPNS](../../actions/workflows/deploy-to-ipns.yml/badge.svg)](../../actions/workflows/deploy-to-ipns.yml)

The Workflow located in .github/workflows/deploy-to-ipns.yml can be used to deploy app/ to ipfs and link it to ipns.
It uses [PINT](https://github.com/chixodo-xyz/pint) as pinning service.

Following variables and secrets are required:

- Repository Secrets: 
	+ IPNS_KEY -> Private Key used for IPNS record (Format: pem-pkcs8-cleartext)
	+ PINT_USERNAME -> Username for authentication on pint pinning service
	+ PINT_PASSWORD -> Password for authentication on pint pinning service
- Repository Variables:
	+ PINT_URL -> URL for pint pinning service
	+ NODE_1 -> Primary IPFS-Node to connect to (node of chixodo-cluster prefered)
	+ NODE_2 -> Secondary IPFS-Node to connect to (node of chixodo-cluster prefered)

## Preparation

To generate a new IPNS-Key use following command:

```bash
bash scripts/initDeployment.sh
```
