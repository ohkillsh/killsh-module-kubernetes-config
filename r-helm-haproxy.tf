
# resource "helm_release" "haproxy_ingress" {
#   name             = "haproxy"
#   repository       = "https://haproxytech.github.io/helm-charts"
#   chart            = "kubernetes-ingress"
#   namespace        = "ingress"
#   force_update     = true
#   create_namespace = true
#   version          = "1.30.6"
#   wait             = false
#   wait_for_jobs    = false

#   set {
#     name  = "namespace-whitelist"
#     value = "dev"
#   }

#   values = [
#     <<-EOF
#     ---
#     autoscaling:
#       enabled: true
#       minReplicas: 2
#       maxReplicas: 7

#     serviceMonitor:
#       enabled: true

#     controller:
#       service:
#         type: "LoadBalancer"
#       ingressClass: haproxy
#       image:
#         pullPolicy: Always

#     ingressClassResource:
#       name: haproxy
#       default: false

#     controller.admissionWebhooks.patch.nodeSelector."kubernetes\.io/os": "linux"
#     defaultBackend.nodeSelector."kubernetes\.io/os": "linux"
#     EOF
#   ]

#   depends_on = [helm_release.prometheus_operator]
# }