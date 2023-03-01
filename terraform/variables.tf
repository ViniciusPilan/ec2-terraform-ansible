variable "instance_type" {
    type = string
    default = "t2.micro"
    description = "Instance type used for EC2 instance."
}

variable "key" {
    type = string
    default = "terraform-ansible-machine"
    description = "SSH key name."
}