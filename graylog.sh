#! /bin/bash

function podstatus (){
	result1=$(microk8s.kubectl get pods --field-selector=status.phase!=Succeeded,status.phase!=Running --all-namespaces)
	while [ ${#result1} -ne 0 ];
	do
		result1=$(microk8s.kubectl get pods --field-selector=status.phase!=Succeeded,status.phase!=Running --all-namespaces)
		sleep 1
	done
}


cd $(find ~ -maxdepth 2 -iname "graylog-fluentbit")

sudo snap install microk8s --classic
sudo microk8s.start
echo "y\n" | sudo microk8s.enable istio


echo "aguarde... processando (Istio - 1/3)"
podstatus

microk8s.kubectl create -f mongo-deploy.yaml
echo "aguarde... processando (Mongodb - 2/3)"
podstatus

echo "aguarde... processando (Graylog - 3/3)"

microk8s.helm install --namespace "graylog" -n "graylog" stable/graylog --values values.yaml






