resource "vault_identity_group" "list" {
  for_each = var.groups
  name     = each.key
  policies = each.value.policies
  member_entity_ids = [
    for username in each.value.members :
    vault_identity_entity.users[username].id
  ]
}
