data "aws_ssm_parameter" "grafana" {
  name = "grafanacloudclienturl"
}

data "aws_ssm_parameter" "grafanatempo" {
  name = "	grafanacloudtempo"
}

resource "kubernetes_secret" "grafanacloud" {

  metadata {
    name      = "grafanacloud"
    namespace = kubernetes_namespace.flux_system.id
  }

  data = {
    url = data.aws_ssm_parameter.grafana.value
    grafana_cloud_tempo_credentials = data.aws_ssm_parameter.grafanatempo.value
  }
}