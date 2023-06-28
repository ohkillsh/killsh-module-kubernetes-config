resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  skip_crds        = true
  wait             = false
  wait_for_jobs    = false

  set {
    name  = "installCRDs"
    value = true
  }

  depends_on = []

}
