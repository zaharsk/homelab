```bash
forgejo admin auth add-oauth \
  --name vault \
  --provider openidConnect \
  --key YOUR_CLIENT_ID \
  --secret YOUR_CLIENT_SECRET \
  --auto-discover-url https://vault.domain.com/.well-known/openid-configuration
```
