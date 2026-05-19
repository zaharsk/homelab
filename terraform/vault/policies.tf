resource "vault_policy" "list" {
  for_each = local.policies_list
  name     = each.key
  policy   = each.value
}
