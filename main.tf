terraform {
  required_providers {
    kubernetes = {}
    helm       = {}
  }
}

resource "aws_secretsmanager_secret" "mariadb_root" {
  name                    = "mariadb_root"
  recovery_window_in_days = 0
}

resource "random_password" "mariadb_root" {
  length           = 24
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret_version" "mariadb_root" {
  secret_id     = aws_secretsmanager_secret.mariadb_root.id
  secret_string = "{\"password\": \"${random_password.mariadb_root.result}\"}"
}

resource "kubernetes_secret" "mariadb_root" {
  metadata {
    name      = "mariadb-root-password"
    namespace = "develop"
    labels = {
      "ConnectOutput" = "true"
    }
  }

  data = {
    password = random_password.mariadb_root.result
  }

  type = "kubernetes.io/basic-auth"
}

resource "helm_release" "mariadb" {
  name             = "mariadb"
  chart            = var.helm_chart_name
  namespace        = var.namespace
  repository       = var.helm_chart
  timeout          = var.helm_timeout
  version          = var.helm_version
  create_namespace = false
  reset_values     = false

  set {
    name  = "auth.rootPassword"
    value = random_password.mariadb_root.result
  }
}



























