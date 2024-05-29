data "exoscale_nlb" "traefik_nlb" {
  zone = local.zone
  name = "traefik-nlb"
}

resource "cloudflare_record" "tenant_todo_life" {
  depends_on = [ data.exoscale_nlb.traefik_nlb ]
  zone_id = var.cloudflare_domain_zone_id
  name = "${var.app_name}.tenantodo.life"
  value = data.exoscale_nlb.traefik_nlb.ip_address
  # value = exoscale_nlb.traefik_nlb.ip_address
  type =  "A"
  proxied = false
}