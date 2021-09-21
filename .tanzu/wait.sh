#!/bin/bash -ex

workload=$1
while [[ -z $(kubectl get pod -o jsonpath='{.items[?(@.metadata.annotations.developer\.apps\.tanzu\.vmware\.com/image-source-digest=="'$(kubectl get imagerepository ${workload}-source -o=jsonpath='{.status.url}')'")].metadata.name}') ]]; do echo "waiting..." && sleep 10; done 
kubectl wait pod --for=condition=ready -l serving.knative.dev/service=$workload,app.kubernetes.io/part-of=$workload