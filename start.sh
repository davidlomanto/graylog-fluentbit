#! /bin/bash

function podstatus (){
        sleep 1
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


echo "aguarde... processando (Istio - 1/4)"
podstatus

microk8s.kubectl create -f mongodb/mongo-deploy.yaml
echo "aguarde... processando (Mongodb - 2/4)"
podstatus

echo "aguarde... processando (Graylog - 3/4)"
microk8s.helm install --namespace "graylog" -n "graylog" stable/graylog --values values.yaml

cd fluentbit
./startfluentbit.sh 
echo "aguarde... processando (FluentBit - 4/4)"
podstatus

export HOST_GRAYLOG=$(microk8s.kubectl get svc -n graylog graylog-web -o jsonpath='{.spec.clusterIP}')
echo -e "\033[01;32mENDEREÇO DE ACESSO AO GRAYLOG:  $HOST_GRAYLOG:9000"
echo
sleep 3





