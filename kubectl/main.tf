data "kubectl_file_documents" "namespace" {
  content = file("${path.module}/manifests/argocd/namespace.yaml")
}

resource "kubectl_manifest" "namespace" {
  for_each  = data.kubectl_file_documents.namespace.manifests
  yaml_body = each.value

  depends_on = [
    data.kubectl_file_documents.namespace
  ]

}

data "kubectl_file_documents" "argocd" {
  content = file("${path.module}/manifests/argocd/install.yaml")

  depends_on = [
    kubectl_manifest.namespace
  ]
}

resource "kubectl_manifest" "argocd" {
  for_each  = data.kubectl_file_documents.argocd.manifests
  yaml_body = each.value

  override_namespace = "argocd"

  depends_on = [
    data.kubectl_file_documents.argocd
  ]
}
