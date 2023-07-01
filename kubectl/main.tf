data "kubectl_file_documents" "namespace" {
  content = file("${path.module}/manifests/argocd/namespace.yaml")
}

resource "kubectl_manifest" "namespace" {
  #count              = length(data.kubectl_file_documents.namespace.documents)
  #yaml_body          = element(data.kubectl_file_documents.namespace.documents, count.index)
  yaml_body = data.kubectl_file_documents.namespace.manifests
  override_namespace = "argocd"

  depends_on = [ data.kubectl_file_documents.namespace ]
}

data "kubectl_file_documents" "argocd" {
  content = file("${path.module}/manifests/argocd/install.yaml")
}

resource "kubectl_manifest" "argocd" {
  #count              = length(data.kubectl_file_documents.argocd.documents)
  #yaml_body          = element(data.kubectl_file_documents.argocd.documents, count.index)
  yaml_body          = data.kubectl_file_documents.argocd.manifests
  override_namespace = "argocd"

  depends_on = [
    kubectl_manifest.namespace
  ]
}
