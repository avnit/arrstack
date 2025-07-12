variable "proxmox_url" {
  description = "The URL of the Proxmox API"
  type        = string
  default     = "https://192.168.74.1:8006/api2/json"
  
}

variable "proxmox_user" {
  description = "The username for the Proxmox API"
  type        = string
  default     = "terraform_user@pam"
}

variable "token_id" {
  description = "The token ID for the Proxmox API"
  type        = string
  default     = "terraform_user@pam!terraform"
}

variable "vm_password" {
  description = "The password for the Debian VM"
  type        = string
  default = "f8061b71-c957-45c3-927e-0485bd477c47"
}
