load("ext://local_output", "local_output")
load("ext://file_sync_only", "file_sync_only")
# -*- mode: Python -*-

# live reload
def tanzu_live_reload(k8s_object, manifest, image, deps=["."], live_update=[]):

    if k8s_object == "":
        fail("k8s_object must be specified")

    if manifest == "":
        fail("manifest must be specified")

    if image == "":
        fail("image must be specified")

    k8s_kind("Workload", image_json_path="{.spec.source.imgpkgBundle.image}")
    k8s_resource(
        k8s_object,
        port_forwards=["8080:8080", "9005:9005"],
        extra_pod_selectors=[
            {"kontinue.io/workload-name": k8s_object},
            {"app.kubernetes.io/component": "run"},
        ],
    )

    file_sync_only(image=image, manifests=manifest, deps=deps, live_update=live_update)

