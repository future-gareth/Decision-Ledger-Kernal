# Decision Ledger Auth (oauth2-proxy + Entra ID)

Templates and assets for protecting the Decision Ledger Demo with Microsoft Entra ID via [oauth2-proxy](https://oauth2-proxy.github.io/oauth2-proxy/).

**Use on the nginx server** (e.g. garethapi.com at 91.99.203.148), not on the app server.

## What to copy to the server

1. **This directory** (e.g. rsync to `/opt/decision-ledger-auth/`).
2. **Create on the server only** (never commit):
   - **`.env`** — `DOMAIN`, `TENANT_ID`, `CLIENT_ID`, `CLIENT_SECRET`, `COOKIE_SECRET` (see `.env.example`).
   - **`allowed_emails.txt`** — one email per line (see `allowed_emails.txt.example`).

## Full instructions

See [docs/DEPLOY-HETZNER-ENTRA-OAUTH2PROXY.md](../../docs/DEPLOY-HETZNER-ENTRA-OAUTH2PROXY.md).

## Quick start on server

```bash
cd /opt/decision-ledger-auth
# Create .env and allowed_emails.txt first
docker compose -f docker-compose.auth.yml up -d
```

Then add the nginx locations and `auth_request` as described in the doc.
