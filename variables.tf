
variable "access_key" {
   default = "paste_your_access_key_here"
}

variable "secret_key" {
  default = "paste_your_secret_key_here"
}

variable "region" {
  default = "ap-south-1" #Provide you region here
}


variable "ami" {
  type = "map"
  default = {
    ap-south-1 = "ami-5b673c34" #Provide your ami ID here
    }
}


variable "PATH_TO_PRIVATE_KEY" {
  default = "paste_your_private_key_path_here"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "paste_your_public_key_path_here"
}

variable "INSTANCE_USERNAME" {
  default = "paste_your_EC2_User_name_here"
}
