# Import de la clé SSH au sein d'OpenStack
resource "openstack_compute_keypair_v2" "test_keypair" {
  provider = "openstack" # Nom du fournisseur déclaré dans provider.tf
  name = "test_keypair" # Nom de la clé SSH à utiliser pour la création
  public_key = "${file("~/openstack.pub")}" # Chemin vers votre clé SSH précédemment générée
  region = "GRA3"
}

# Création d'une machine virtuelle OpenStack
resource "openstack_compute_instance_v2" "dops-ren-ub" {
  name = "dops-ren-ub-${count.index}" # Nom de l'instance
  count = "2"
  provider = "openstack" # Nom du fournisseur
  flavor_name = "s1-2" # Nom du type de machine
  region = "GRA3"
  block_device {
    uuid                  = "d1517a07-bc48-4523-b80c-b22f4e506c9e"
    source_type           = "image"
    volume_size           = 40
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }
  # Nom de la ressource openstack_compute_keypair_v2 no mmé test_keypair
  key_pair = "${openstack_compute_keypair_v2.test_keypair.name}"
   network {
     name = "Ext-Net" # Ajoute le réseau public à votre instance
   }
}

# Création d'une machine virtuelle OpenStack
resource "openstack_compute_instance_v2" "dops-centos" {
  name = "dops-ren-centos-${count.index}" # Nom de l'instance
  provider = "openstack" # Nom du fournisseur
  image_name = "Centos 6" # Nom de l'image
  flavor_name = "s1-2" # Nom du type de machine
  region = "GRA3"
  # Nom de la ressource openstack_compute_keypair_v2 nommé test_keypair
  key_pair = "${openstack_compute_keypair_v2.test_keypair.name}"
}
