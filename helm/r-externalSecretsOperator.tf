resource "helm_release" "external_secrets_operator" {
  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  namespace        = "external-secrets"
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
