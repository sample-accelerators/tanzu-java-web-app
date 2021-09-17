custom_build('harbor-repo.vmware.com/tanzu_desktop/sample-app-java', 
  'tanzu apps workload apply -f config/workload.yaml --local-path=. --yes && \
    workload=$(cat config/workload.yaml |  awk '/name/ { print $2}' | head -n 1) && \
    imageRef=$(kubectl get workload sample-app-java -o=jsonpath='{.spec.source.image}') && \
    jsonpath="{.items[?(@.metadata.annotations.developer\.apps\.tanzu\.vmware\.com/image-source-digest==$imageRef)].metadata.name}"
    while [[ $(kubectl get pod -o jsonpath=$jsonpath) != "True" ]]; do echo "waiting for ksvc" && sleep 10; done

    kubectl get pod -o=jsonpath='{.items[?(@.metadata.annotations.developer\.apps\.tanzu\.vmware\.com/image-source-digest=="mingxiao10016/sample-app-java-source")].metadata.name}'

     kubectl wait pod --for=condition=ready -l carto.run/workload-name=$workload,app.kubernetes.io/part-of=$workload
  ['pom.xml', './target/classes'],
  live_update = [
    sync('./target/classes', '/workspace/BOOT-INF/classes')
  ],
  skips_local_docker=True
)

k8s_yaml('./config/workload.yaml')
k8s_kind('Workload', image_json_path='{.spec.params[?(@.name=="run-image")].value}')
k8s_resource(workload='sample-app-java', extra_pod_selectors=[{'serving.knative.dev/service':'sample-app-java'}])
