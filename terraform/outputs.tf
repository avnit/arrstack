output "debian_vm_ip" {
  description = "The IP address of the Debian VM."
  value       = proxmox_vm_qemu.debian_vm.default_ipv4_address
}
