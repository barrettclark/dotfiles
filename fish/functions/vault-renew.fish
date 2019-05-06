function vault-renew --description 'Renew vault token and set VAULT_TOKEN env var'
    set -gx VAULT_ADDR https://vault.containerstore.com
    set -gx VAULT_TOKEN
    rm ~/.vault-token
    vault login -method=ldap username=(whoami)
    set -gx VAULT_TOKEN (cat ~/.vault-token)

    vault write -field=signed_key ssh-client-signer/sign/dev \
        public_key=@$HOME/.ssh/id_rsa.pub > $HOME/.ssh/id_rsa-cert.pub

    ssh-add
end
