SOURCE_IMAGE = os.getenv("SOURCE_IMAGE", default='your-registry.io/project/tanzu-java-web-app-source')
LOCAL_PATH = os.getenv("LOCAL_PATH", default='.')

k8s_custom_deploy(
    'tanzu-java-web-app',
    apply_cmd="tanzu apps workload apply -f config/workload.yaml --live-update --local-path " + LOCAL_PATH + " --source-image " + SOURCE_IMAGE + " --yes >/dev/null " +
              "&& kubectl get workload tanzu-java-web-app -o yaml",
    delete_cmd="tanzu apps workload delete -f config/workload.yaml --yes",
    deps=['pom.xml', './target/classes'],
    image_selector='your-registry.io/project/tanzu-java-web-app',
    live_update=[
      sync('./target/classes', '/workspace/BOOT-INF/classes')
    ]
)

k8s_resource('tanzu-java-web-app', port_forwards=["8080:8080"],
            extra_pod_selectors=[{'serving.knative.dev/service': 'tanzu-java-web-app'}])
