# Import de la clé SSH au sein d'OpenStack
resource "openstack_compute_keypair_v2" "test_keypair" {
  provider = "openstack" # Nom du fournisseur déclaré dans provider.tf
  name = "test_keypair" # Nom de la clé SSH à utiliser pour la création
  public_key = "${file("./openstack.pub")}" # Chemin vers votre clé SSH précédemment générée
  region = "GRA3"
}


resource "openstack_blockstorage_volume_v2" "dops-ren-ub" {
  count = 2
  name = "${var.project}-ub-${count.index}"
  size = 20
}

resource "openstack_blockstorage_volume_v2" "dops-ren-centos" {
  name = "${var.project}-centos"
  size = 20
}

resource "openstack_compute_volume_attach_v2" "va_1" {
  instance_id = "${element(openstack_compute_instance_v2.dops-ren-ub.*.id, count.index)}"
  volume_id   = "${element(openstack_blockstorage_volume_v2.dops-ren-ub.*.id, count.index)}"
}

resource "openstack_compute_volume_attach_v2" "va_2" {
  instance_id = "${element(openstack_compute_instance_v2.dops-ren-centos.*.id, count.index)}"
  volume_id   = "${element(openstack_blockstorage_volume_v2.dops-ren-centos.*.id, count.index)}"
}

# Création d'une machine virtuelle OpenStack
resource "openstack_compute_instance_v2" "dops-ren-ub" {
  name = "${var.project}-ub-${count.index}" # Nom de l'instance
  count = "2"
  provider = "openstack" # Nom du fournisseur
  image_name = "Ubuntu 16.04" # Nom de l'image
  flavor_name = "s1-2" # Nom du type de machine
  region = "GRA3"
  # Nom de la ressource openstack_compute_keypair_v2 no mmé test_keypair
  key_pair = "${openstack_compute_keypair_v2.test_keypair.name}"
   network {
     name = "Ext-Net" # Ajoute le réseau public à votre instance
   }
}

# Création d'une machine virtuelle OpenStack
resource "openstack_compute_instance_v2" "dops-ren-centos" {
  name = "${var.project}-centos-${count.index}" # Nom de l'instance
  provider = "openstack" # Nom du fournisseur
  image_name = "Centos 6" # Nom de l'image
  flavor_name = "s1-2" # Nom du type de machine
  region = "GRA3"
  # Nom de la ressource openstack_compute_keypair_v2 nommé test_keypair
  key_pair = "${openstack_compute_keypair_v2.test_keypair.name}"
}
