variable "resourcegroup" {
  type = map(object({
    location = string
  }))
}