custom_build('harbor-repo.vmware.com/tanzu_desktop/sample-app-java', 
  'kubectl delete pods -l app.kubernetes.io/component=build,kontinue.io/workload-name=sample-app-java && \
    tanzu apps workload apply sample-app-java --label="app.tanzu.vmware.com/workload-type=web" --imgpkg-bundle=harbor-repo.vmware.com/tanzu_desktop/sample-app-java-source --local-path=. --yes && \
    while [[ $(kubectl get ksvc sample-app-java -o \'jsonpath={..status.conditions[?(@.type=="Ready")].status}\') != "True" ]]; do echo "waiting for ksvc" && sleep 10; done',
  ['pom.xml', './target/classes'],
  live_update = [
    sync('./target/classes', '/workspace/BOOT-INF/classes')
  ],
  skips_local_docker=True
)

k8s_yaml('./config/workload.yaml')
k8s_kind('Workload', image_json_path='{.metadata.run-image}')
k8s_resource(workload='sample-app-java', extra_pod_selectors=[{'serving.knative.dev/service':'sample-app-java'}])
