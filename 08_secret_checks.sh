clear
echo "---> To run where kubectl has access to k8s cluster"
echo "---> Create a secret post- Trousseau deployment"
echo "CLI: kubectl create secret generic secret-post-deploy -n default --from-literal=mykey=mydata"
kubectl create secret generic secret-post-deploy -n default --from-literal=mykey=mydata
echo 
echo "---> Check recorded payload within ETCD"
echo "CLI: kubectl -n kube-system exec etcd-tdevk8s-01.trousseau.io -- sh -c \"ETCDCTL_ENDPOINTS='https://127.0.0.1:2379' ETCDCTL_CACERT='/var/lib/rancher/rke2/server/tls/etcd/server-ca.crt' ETCDCTL_CERT='/var/lib/rancher/rke2/server/tls/etcd/server-client.crt' ETCDCTL_KEY='/var/lib/rancher/rke2/server/tls/etcd/server-client.key' ETCDCTL_API=3 etcdctl get /registry/secrets/default/secret-post-deploy\" | hexdump -C"
echo 
kubectl -n kube-system exec etcd-tdevk8s-01.trousseau.io -- sh -c "ETCDCTL_ENDPOINTS='https://127.0.0.1:2379' ETCDCTL_CACERT='/var/lib/rancher/rke2/server/tls/etcd/server-ca.crt' ETCDCTL_CERT='/var/lib/rancher/rke2/server/tls/etcd/server-client.crt' ETCDCTL_KEY='/var/lib/rancher/rke2/server/tls/etcd/server-client.key' ETCDCTL_API=3 etcdctl get /registry/secrets/default/secret-post-deploy" | hexdump -C
echo 
echo "end of 08_secret_checks.sh" 
