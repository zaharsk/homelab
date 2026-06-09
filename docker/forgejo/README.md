## Create OIDC client in Forgejo container (user `git`)

```sh
forgejo admin auth add-oauth \
	--name Vault \
	--provider openidConnect \
	--icon-url <VAULT_FAVICON_URL> \
	--scopes email,profile,groups \
	--key <FORGEJO_OIDC_CLIENT_ID> \
	--secret <FORGEJO_OIDC_CLIENT_SECRET> \
	--auto-discover-url <VAULT_URL>/v1/identity/oidc/provider/default/.well-known/openid-configuration
	--required-claim-name groups \
	--required-claim-value forgejo-users \
	--group-claim-name groups \
	--admin-group forgejo-admins
```

```bash
forgejo forgejo-cli actions register \
	--name ubuntu-y \
    --secret "$(openssl rand -hex 20)"
```
