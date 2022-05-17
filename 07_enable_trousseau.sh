echo "---> To run where kubectl has access to k8s cluster"
echo "---> Create the EncryptionConfiguration manifest on k8s"
echo "CLI: cat vault-kms-encryption-config.yaml"
cat vault-kms-encryption-config.yaml
echo 
echo "---> Push the EncryptionConfiguration manifest on k8s"
echo "CLI: cp vault-kms-encryption-config.yaml /var/lib/rancher/rke2/server/cred/vault-kms-encryption-config.yaml"
cp vault-kms-encryption-config.yaml /var/lib/rancher/rke2/server/cred/vault-kms-encryption-config.yaml
echo "---> Restart the k8s api-server to acknowledge the change"
echo "CLI: systemctl restart rke2-server"
systemctl restart rke2-server
