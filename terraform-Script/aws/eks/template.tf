
data "aws_eks_cluster_auth" "ephemeral" {
  name = "${var.project}-cluster"	
}

locals {
  kubeconfig = <<KUBECONFIG

apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.this.endpoint}
    certificate-authority-data: ${aws_eks_cluster.this.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    token: ${data.aws_eks_cluster_auth.ephemeral.token}
    
KUBECONFIG
}


resource "local_file" "kubefile" {
  content  = "${local.kubeconfig}"
  filename = "${path.module}/kubefile"
}
