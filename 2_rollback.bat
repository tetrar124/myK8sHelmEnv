helm del mysql --purge
kubectl delete -f ubuntu.yaml
kubectl delete -f pvc.yaml
kubectl delete -f persistentVol.yaml
kubectl delete -f localstrage.yaml