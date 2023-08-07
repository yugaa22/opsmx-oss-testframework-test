resource "helm_release" "nginx" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace = "ingress-nginx"
  create_namespace = "true"
  set {
    name  = "apiService.create"
    value = "true"
  }

  depends_on = [
    module.aws_eks_cluster.this
  ]
}

resource "helm_release" "cert_manager" {
  name       = "jetstack"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace = "cert-manager"
  create_namespace = "true"
  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [
    module.eks
  ]
}
