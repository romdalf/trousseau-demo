echo "---> To run where kubectl has access to k8s cluster"
echo "---> Recover Configuration parameter to enable k8s auth in Vault"
echo "---> Getting VAULT_SA_NAME"
export VAULT_SA_NAME=$(kubectl -n kube-system get sa vault-auth \
    --output jsonpath="{.secrets[*]['name']}")
echo "---> Getting SA_JWT_TOKEN"
export SA_JWT_TOKEN=$(kubectl -n kube-system get secret $VAULT_SA_NAME \
    --output 'go-template={{ .data.token }}' | base64 --decode)
echo "---> Getting SA_CA_CRT "
export SA_CA_CRT=$(kubectl -n kube-system config view --raw --minify --flatten \
    --output 'jsonpath={.clusters[].cluster.certificate-authority-data}' | base64 --decode)
echo "---> Getting K8S_HOST"
export K8S_HOST=$(kubectl config view --raw --minify --flatten \
    --output 'jsonpath={.clusters[].cluster.server}')
echo 
echo "---> To run where vault has access to Vault cluster"
echo "CLI: vault auth enable kubernetes"
echo vault write auth/kubernetes/config token_reviewer_jwt="\"$SA_JWT_TOKEN\"" kubernetes_ca_cert="\"$SA_CA_CRT\"" issuer="\"https://kubernetes.default.svc.cluster.local\"" kubernetes_host=\"https://tdevk8s-01.trousseau.io:6443\"
echo 
echo "/!\ If kubernetes_host is https://127.0.0.1:6443 - replace it with your k8s cluster API endpoint URL"
echo 
