helm del mysql --purge
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.8.3/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl delete -f ubuntu.yaml
kubectl delete -f pvc.yaml
kubectl delete -f persistentVol.yaml
kubectl delete -f localstrage.yaml
