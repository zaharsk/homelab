variable "hosts" {
  type = map(
    object({
      ip     = string
      user   = string
      groups = list(string)
    })
  )
}
