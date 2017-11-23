resource "openstack_compute_keypair_v2" "dops-ren" {
  name       = "dops-ren"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDZH8CO7ijcMTQcuhox/yU0ddftgyO2FypX/ahcOGmWjemdHlu7bDtSBGcf/AV6p0kf64sJy7ig63uImesMjQsFxWN7DejiiUWwZtIz1kqVDDr48pKKuvcjAQlxjwH2l4H+oeMs1e+QWfVe/QnjpX0/C59zOSqBDyOfURBywb0FqyhpteBsxSKn6xF/qhs5Moq53B2HAc93P76vtylIBMcFfPqIChyePv7QbkjSnD0AYqJLYx7fGGzMqm9WD/iktN03s1RvyCR23rKZz0dwxAsEKdLjJ3MHPJprcjZiG1M0Wp0doxYOmno/U9InIyRD5jgwZjyzDFQeY+XuK/TSeY3omLsxpuPGTgKSvqJmiNPgZ1HeOQM95eR8NH2uUCVaJtyoFRDyvqExouELGrnJjDN0Y5Im7944Uw0MDi51GIUSihA9MUu9YY2agKPvwzh4VsVFXXs5qIWKpNaGb+NSbxQ8puZ0c86JOxjhua2123Hw28LfG+dffEJTbX3WD1B8x/n3dZ/zn0OmZ07rXV5fqQv2zprDFJgwp7YV5mnFgce8fv7yxpyNp7j5kD59FuzzHbNd3f/02ak1u19/YSEv5erNIKzuZ271eVe3TRgZgG71LjijryxlxYOIFtGTURwMCujbRUiN0rHO49dVwmt2ZqbALQ/Or7jiWvj51xXNEy2uSQ== joels@DESKTOP-CINT5P9"
}

resource "openstack_compute_instance_v2" "web" {
  name = "web"
  image_name = "CentOS6"
  availability_zone = "GRA3"
  flavor_name = "B2-7"
  key_pair = "${openstack_compute_keypair_v2.dops-ren.public_key}"
  security_groups = ["default"]
  # user_data = "${file("bootstrapweb.sh")}"
}
