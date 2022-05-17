clear
echo "---> To run where kubectl has access to k8s cluster"
echo "---> Create a ServiceAccount to connect to Vault"
echo "CLI: kubectl -n kube-system create serviceaccount vault-auth"
kubectl -n kube-system create serviceaccount vault-auth
echo 
echo "---> Create the RBAC rules linked to the ServiceAccount"
echo "CLI: cat vault-auth-serviceaccount.yaml"
cat vault-auth-serviceaccount.yaml
echo 
echo "---> Apply ServiceAccount RBAC rules on k8s"
echo "CLI: kubectl apply -f vault-auth-serviceaccount.yaml"
kubectl apply -f vault-auth-serviceaccount.yaml
echo 
echo "end of 03_serviceaccount.sh" 
