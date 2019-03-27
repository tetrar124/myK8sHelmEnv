cd /C/OneDrive/Programing/myK8sHelmEnv
helm delete mysql --purge
helm install stable/mysql --name mysql -f mysqlConfig.yml

export MYSQL_HOST=127.0.0.1
export MYSQL_PORT=3306
kubectl run -i --tty ubuntu --image=ubuntu:16.04 --restart=Never -- bash -il
apt-get update && apt-get install mysql-client -y
mysql -h mysql -P 3306 -u test1 -ptest1