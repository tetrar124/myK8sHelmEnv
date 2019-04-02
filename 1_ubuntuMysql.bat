kubectl apply -f localstrage.yaml
kubectl apply -f persistentVol.yaml
kubectl apply -f pvc.yaml
kubectl apply -f ubuntu.yaml
helm init
helm install --name mysql stable/mysql -f mysqlConfig.yaml