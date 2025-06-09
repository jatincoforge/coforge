variable "resourcegroup" {
  type = map(object({
    location = string
    #tags = string
  }))
}

variable "key_vault_name" {
  type = string
}
variable "vm_name" {
  type = string
}