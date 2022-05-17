clear
echo "---> To run where kubectl has access to k8s cluster"
echo "---> Create a ConfigMap to recover Transit Engine config"
echo "CLI: cat trousseau-configmap.yaml"
cat trousseau-configmap.yaml
echo 
echo "---> Apply ConfigMap on k8s"
echo "CLI: kubectl apply -f trousseau-configmap.yaml"
kubectl apply -f trousseau-configmap.yaml
echo "---> Create DaemonSet to deploy Trousseau"
echo "CLI: cat trousseau-daemonset.yaml"
cat trousseau-daemonset.yaml
echo "---> Apply DaemonSet on k8s"
echo "CLI: kubectl apply -f trousseau-daemonset.yaml"
kubectl apply -f trousseau-daemonset.yaml
echo "---> Check Trousseau Pod creation"
echo "CLI: kubectl get pods -A|grep vault"
echo "/!\ CTRL+C to break the command"
kubectl get pods -A -w|grep vault
echo 
echo "end of 06_deploy_trousseau.sh"
