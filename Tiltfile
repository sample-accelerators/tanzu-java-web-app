load('.tanzu/tanzu_tilt_extensions.py', 'tanzu_k8s_yaml')

SOURCE_IMAGE = os.getenv("SOURCE_IMAGE", default='your-registry.io/project/sample-app-java-source')

custom_build('your-registry.io/project/sample-app-java',
    "tanzu apps workload apply -f config/workload.yaml --live-update --local-path . --source-image " + SOURCE_IMAGE + " --yes && \
    .tanzu/wait.sh sample-app-java",
  ['pom.xml', './target/classes'],
  live_update = [
    sync('./target/classes', '/workspace/BOOT-INF/classes')
  ],
  skips_local_docker=True
)

tanzu_k8s_yaml('sample-app-java', 'your-registry.io/project/sample-app-java', './config/workload.yaml')
