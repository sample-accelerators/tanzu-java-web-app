load('.tanzu/tanzu_tilt_extensions.py', 'tanzu_k8s_yaml')

SOURCE_IMAGE_NAME = os.getenv("SOURCE_IMAGE_NAME", default='tanzu-java-web-app-source')
RUN_IMAGE_NAME = os.getenv("RUN_IMAGE_NAME", default='tanzu-java-web-app')
REGISTRY = os.getenv("REGISTRY", default='your-registry.io/project')
LOCAL_PATH = os.getenv("LOCAL_PATH", default='.')

SOURCE_IMAGE = "%s/%s" %(REGISTRY, SOURCE_IMAGE_NAME)
RUN_IMAGE = "%s/%s" %(REGISTRY, RUN_IMAGE_NAME)

command = "tanzu apps workload apply -f config/workload.yaml --live-update --local-path %s --source-image %s --yes && .tanzu/wait.sh %s" %(LOCAL_PATH, SOURCE_IMAGE, RUN_IMAGE_NAME)

custom_build(RUN_IMAGE, command,
  ['pom.xml', './target/classes'],
  live_update = [
    sync('./target/classes', '/workspace/BOOT-INF/classes')
  ],
  skips_local_docker=True
)

tanzu_k8s_yaml(RUN_IMAGE_NAME, RUN_IMAGE, './config/workload.yaml')
