resource "null_resource" "local_command" {
  provisioner "local-exec" {
    command = "echo Hello, Terraform!"
  }
}
