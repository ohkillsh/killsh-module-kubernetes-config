# ARGO CD

## tasks

    kubectl patch secret argocd-secret  -p '{"data": {"admin.password": null, "admin.passwordMtime": null}}' -n argocd
    
    kubectl scale deployment argocd-server --replicas 0 -n argocd
    kubectl scale deployment argocd-server --replicas 1 -n argocd
    
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo

## Exemplo de uso 

```yaml
module "k8s_config_manifests" {
  source = "git@github.com:ohkillsh/killsh-module-kubernetes-config.git//kubectl?ref=main"

  depends_on = [ ]
}
```
