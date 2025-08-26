variable "proxmox_url" {
  description = "The URL of the Proxmox API."
  type        = string
}

variable "token_id" {
  description = "The Proxmox API token ID."
  type        = string
}

variable "vm_password" {
  description = "The password for the VM."
  type        = string
  sensitive   = true
}

variable "ssh_private_key_path" {
  description = "The path to the SSH private key."
  type        = string
  default     = "~/.ssh/id_ed25519"
}

variable "proxmox_host" {
  description = "The IP address of the Proxmox host."
  type        = string
}