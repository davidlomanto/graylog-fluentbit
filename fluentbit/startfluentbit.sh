#!/bin/sh

# (Found at https://github.com/fluent/fluent-bit-kubernetes-logging and updated)
# Create the namespace
microk8s.kubectl create namespace graylog

# Create the base resources
microk8s.kubectl create -f fluent-bit-service-account.yaml
microk8s.kubectl create -f fluent-bit-role.yaml
microk8s.kubectl create -f fluent-bit-role-binding.yaml

# Create the config map
# See https://github.com/fluent/fluent-bit/issues/851 for the GELF parameters.
microk8s.kubectl create -f fluent-bit-configmap.yaml

# Create the daemon set
microk8s.kubectl create -f fluent-bit-daemon-set.yaml

