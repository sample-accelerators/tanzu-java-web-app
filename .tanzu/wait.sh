#!/bin/bash -ex

workload=$1
while [[ -z $(kubectl get pod -o jsonpath='{.items[?(@.metadata.annotations.developer\.apps\.tanzu\.vmware\.com/image-source-digest=="'$(kubectl get workload ${workload} -o=jsonpath='{.spec.source.image}')'")].metadata.name}') ]]; do echo "waiting..." && sleep 10; done 
kubectl wait pod --for=condition=ready -l carto.run/workload-name=$workload,app.kubernetes.io/part-of=$workload