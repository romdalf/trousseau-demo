echo "---> To run where vault has access to Vault cluster"
echo "---> Start Vault dev instance"
echo "CLI: vault server -dev -dev-listen-address 0.0.0.0:8200"
vault server -dev -dev-root-token-id=trousseau-demo -dev-listen-address 0.0.0.0:8200
echo 
echo "end of 01_vault_init.sh"
