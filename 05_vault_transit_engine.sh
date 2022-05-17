echo "---> To run where vault has access to Vault cluster"
echo "---> Enable Vault Transit Engine Service"
echo "CLI: vault secrets enable transit"
vault secrets enable transit
echo "---> Create a dedicated Trousseau Transit Engine"
echo "CLI: vault write -f transit/keys/trousseau-kms-vault"
vault write -f transit/keys/trousseau-kms-vault
echo "---> Create Trousseau Transit Access Policy"
echo "CLI: 
vault policy write trousseau-transit-ro -<<EOF
path "transit/encrypt/trousseau-kms-vault" {
   capabilities = [ "update" ]
}
path "transit/decrypt/trousseau-kms-vault" {
   capabilities = [ "update" ]
}
EOF"
vault policy write trousseau-transit-ro -<<EOF
path "transit/encrypt/trousseau-kms-vault" {
   capabilities = [ "update" ]
}
path "transit/decrypt/trousseau-kms-vault" {
   capabilities = [ "update" ]
}
EOF
echo "---> Create a dedicated Vault Token for Trousseau"
echo "CLI: vault token create -policy=trousseau-transit-ro"
vault token create -policy=trousseau-transit-ro
echo "---> Copy/Paste the TOKEN"
read TROUSSEAU_TOKEN
echo $TROUSSEAU_TOKEN
echo 
echo "---> Create a Vault Secret for Trousseau configuration"
echo "CLI: vault policy write trousseau-kv-ro - <<EOF
path "secret/data/trousseau/*" {
    capabilities = ["read", "list"]
}
EOF"
vault policy write trousseau-kv-ro - <<EOF
path "secret/data/trousseau/*" {
    capabilities = ["read", "list"]
}
EOF
echo "---> Store the configuration to the KV store"
echo "CLI: vault kv put /secret/trousseau/config transitkeyname=trousseau-kms-vault \
vaultaddress=$VAULT_ADDR vaulttoken=$TROUSSEAU_TOKEN \
 ttl=30s"
vault kv put /secret/trousseau/config transitkeyname=trousseau-kms-vault \
vaultaddress=$VAULT_ADDR vaulttoken=$TROUSSEAU_TOKEN \
 ttl=30s
echo "---> Link the ServiceAccount, the Transit, Secret and policies"
echo "CLI: vault write auth/kubernetes/role/trousseau \
        bound_service_account_names=vault-auth \
        bound_service_account_namespaces=kube-system \
        policies=trousseau-kv-ro \
        ttl=24h"
vault write auth/kubernetes/role/trousseau \
        bound_service_account_names=vault-auth \
        bound_service_account_namespaces=kube-system \
        policies=trousseau-kv-ro \
        ttl=24h
