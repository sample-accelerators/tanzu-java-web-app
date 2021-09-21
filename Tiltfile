load('.tanzu/tanzu_tilt_extensions.py', 'tanzu_k8s_yaml')

custom_build('harbor-repo.vmware.com/tanzu_desktop/sample-app-java', 
    "tanzu apps workload apply -f config/workload.yaml --live-update --local-path=. --yes && \
    .tanzu/wait.sh sample-app-java",
  ['pom.xml', './target/classes'],
  live_update = [
    sync('./target/classes', '/workspace/BOOT-INF/classes')
  ],
  skips_local_docker=True
)
  
tanzu_k8s_yaml('sample-app-java', 'harbor-repo.vmware.com/tanzu_desktop/sample-app-java', './config/workload.yaml')
