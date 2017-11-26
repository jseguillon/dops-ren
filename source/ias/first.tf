# Import de la clé SSH au sein d'OpenStack
resource "openstack_compute_keypair_v2" "test_keypair" {
  provider = "openstack" # Nom du fournisseur déclaré dans provider.tf
  name = "test_keypair" # Nom de la clé SSH à utiliser pour la création
  public_key = "${file("~/openstack.pub")}" # Chemin vers votre clé SSH précédemment générée
  region = "GRA3"
}

# Création d'une machine virtuelle OpenStack
resource "openstack_compute_instance_v2" "test_terraform_instance" {
  name = "ubuntu-${count.index}" # Nom de l'instance
  count = "2"
  provider = "openstack" # Nom du fournisseur
  image_name = "Ubuntu 16.04" # Nom de l'image
  flavor_name = "s1-2" # Nom du type de machine
  region = "GRA3"
  # Nom de la ressource openstack_compute_keypair_v2 nommé test_keypair
  key_pair = "${openstack_compute_keypair_v2.test_keypair.name}"
   network {
     name = "Ext-Net" # Ajoute le réseau public à votre instance
   }
}
