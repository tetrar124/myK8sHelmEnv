kubectl apply -f localstrage.yaml
kubectl apply -f persistentVol.yaml
kubectl apply -f pvc.yaml
kubectl create secret docker-registry regcred --docker-server=https://index.docker.io/v1/ --docker-username=tetrar124 --docker-password=liwata2--3 --docker-email=tetrar124@gmail.com
kubectl apply -f ubuntu.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.8.3/src/deploy/recommended/kubernetes-dashboard.yaml
helm init
helm install --name mysql stable/mysql -f mysqlConfig.yaml