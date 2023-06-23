resource "helm_release" "prometheus_operator" {
  name             = "prometheus-operator"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  force_update     = true
  create_namespace = true
  
  wait             = false
  wait_for_jobs    = false

  values = [
    <<-EOL
    # Forcing Kubelet metrics scraping on http
    kubelet:
      enabled: true
      serviceMonitor:
        https: false

    # Disabling scraping of Master Nodes Components
    kubeControllerManager:
      enabled: false

    kubeScheduler:
      enabled: false

    kubeEtcd:
      enabled: false

    kubeProxy:
      enabled: false

    grafana:
      plugins:
        - grafana-piechart-panel

    prometheusOperator:
      admissionWebhooks:
        enabled: false
      tls:
        enabled: false
      # https://github.com/prometheus-community/helm-charts/issues/106
      prometheusSpec:
        podMonitorNamespaceSelector:
          any: true
        podMonitorSelector: {}
        podMonitorSelectorNilUsesHelmValues: false
        ruleNamespaceSelector:
          any: true
        ruleSelector: {}
        ruleSelectorNilUsesHelmValues: false
        serviceMonitorNamespaceSelector:
          any: true
        serviceMonitorSelector: {}
        serviceMonitorSelectorNilUsesHelmValues: false
    EOL
  ]
}

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
