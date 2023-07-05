resource "helm_release" "prometheus_operator" {
  name             = "prometheus-operator"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  force_update     = true
  create_namespace = true

  wait          = false
  wait_for_jobs = false

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
