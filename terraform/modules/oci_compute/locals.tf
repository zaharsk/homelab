locals {
  last_ad = data.oci_identity_availability_domains.ads.availability_domains[
    length(data.oci_identity_availability_domains.ads.availability_domains) - 1
  ].name
}