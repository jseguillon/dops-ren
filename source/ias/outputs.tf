output "ub-ip" {
  value = "${openstack_compute_instance_v2.dops-ren-ub.*.access_ip_v4}"
}

output "centos-ip" {
  value = "${openstack_compute_instance_v2.dops-ren-centos.*.access_ip_v4}"
}
