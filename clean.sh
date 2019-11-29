

cd fluentbit
# delete the base resources
microk8s.kubectl delete -f fluent-bit-service-account.yaml
microk8s.kubectl delete -f fluent-bit-role.yaml
microk8s.kubectl delete -f fluent-bit-role-binding.yaml

# delete the config map
# See https://github.com/fluent/fluent-bit/issues/851 for the GELF parameters.
microk8s.kubectl delete -f fluent-bit-configmap.yaml

# delete the daemon set
microk8s.kubectl delete -f fluent-bit-daemon-set.yaml

# delete mongodb
microk8s.kubectl delete -f ../mongodb/mongo-deploy.yaml

microk8s.helm del --purge graylog

