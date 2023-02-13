variable region {
    type = string
    default = "us-east-1"
}

variable instance_type {
    type = string
    default = "t2.micro"
}

variable ami {
    type = string
    default = "ami-0557a15b87f6559cf"
}

variable key {
    type = string
    default = "dev-key"
}

variable key_path {
    type = string
    default = "."
}

variable bucket_name {
    type = string
    default = "s3-website-content.vinipilan.com"
}