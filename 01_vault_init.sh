echo "---> To run where vault has access to Vault cluster"
echo "---> Start Vault dev instance"
echo "CLI: vault server -dev -dev-listen-address 0.0.0.0:8200"
vault server -dev -dev-root-token-id=trousseau-demo -dev-listen-address 0.0.0.0:8200
echo 
echo "---> Access Vault with the CLI, export the following parameters:"
echo "CLI: export VAULT_ADDR=http://tdevhvc-01.trousseau.io:8200"
echo "CLI: export VAULT_TOKEN=trousseau-demo"
echo 

