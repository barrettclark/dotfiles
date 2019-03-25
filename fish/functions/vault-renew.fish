function vault-renew --description 'Renew vault token and set VAULT_TOKEN env var'
    set -x VAULT_ADDR https://vault.containerstore.com
    set -x VAULT_TOKEN
    rm ~/.vault-token
    vault auth -method=ldap username=(whoami)
    set VAULT_TOKEN (cat ~/.vault-token)

    vault write -field=signed_key ssh-client-signer/sign/ops \
        public_key=@$HOME/.ssh/id_rsa.pub > $HOME/.ssh/id_rsa-cert.pub

    ssh-add
end
