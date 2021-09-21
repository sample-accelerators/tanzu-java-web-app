def tanzu_k8s_yaml(workload, run_image, yaml):

  # 1. Create fake deployment
  deployment_template = """
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {workload}-proxy
  annotations:
    run-image: {run_image}
"""
  deployment = deployment_template.format(workload=workload, run_image=run_image)
  
  k8s_yaml(blob(deployment))
  k8s_kind('ConfigMap', image_json_path="{.metadata.annotations.run-image}")
  k8s_resource(workload + '-proxy', port_forwards=["8080:8080"],
              extra_pod_selectors=[{'serving.knative.dev/service' : workload}], discovery_strategy="selectors-only")