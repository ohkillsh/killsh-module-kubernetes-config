
# Exposing traefik dashboard kubectl port-forward $(kubectl get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000
# It can then be reached at: http://127.0.0.1:9000/dashboard/
resource "helm_release" "ingress_traefik" {
  name             = "traefik"
  repository       = "https://traefik.github.io/charts"
  chart            = "traefik"
  namespace        = "ingress"
  force_update     = true
  create_namespace = true
  wait             = false
  wait_for_jobs    = false

  values = [
    <<-EOL
    EOL
  ]
}