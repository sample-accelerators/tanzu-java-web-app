#!/bin/bash -e

workloadName=$1
imageRef=$(kubectl get workload ${workloadName} -o=jsonpath='{.spec.source.image}')
jsonpath='{.items[?(@.metadata.annotations.developer\.apps\.tanzu\.vmware\.com/image-source-digest=="'$imageRef'")].metadata.name}'
while [[ -z $(kubectl get pod -o jsonpath=$jsonpath) ]]; do echo "Waiting for new workload \"${workloadName}\"" && sleep 10; done
podName=$(kubectl get pod -o jsonpath=$jsonpath)
kubectl wait pod --for=condition=ready $podName