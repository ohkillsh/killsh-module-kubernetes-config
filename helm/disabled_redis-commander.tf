
# resource "helm_release" "redis_commander" {
#   name       = "redis-commander"
#   repository = "https://github.com/joeferner/redis-commander/tree/master/k8s/helm-chart/"
#   chart      = "redis-commander"
#   version    = "0.1.12"

#   namespace        = "tshoot"
#   force_update     = true
#   create_namespace = true


#   values = [
#    <<-EOL
#    redis.host: redis-master
#    # env:
#    # - name: FOLDING_CHAR
#    #   value: "/"
#    ingress:
#    enabled: true
#    annotations:
#        kubernetes.io/ingress.class: nginx
#    hosts:
#        - host: redis-ui.example.com
#        paths: ["/"]
#    EOL
#    ]

#   depends_on = [helm_release.prometheus_operator]

# }

# resource "helm_release" "nginx_test" {
#   name       = "nginx-test"
#   repository = "https://charts.bitnami.com/bitnami/"
#   chart      = "nginx"
#   version    = "15.0.2"

#   namespace        = "dev"
#   force_update     = true
#   create_namespace = true

#   depends_on = [helm_release.prometheus_operator]

# }