echo 'tags:
  install-mongodb: false
  install-elasticsearch: false
graylog:
  mongodb:
    uri: "mongodb://mongodb:27017/graylog"
  elasticsearch:
    hosts: "http://elasticsearch:9200"' > values.yaml


microk8s.kubectl create -f mongo-deploy.yaml

helm install --namespace "graylog" -n "graylog" stable/graylog --values values.yaml






