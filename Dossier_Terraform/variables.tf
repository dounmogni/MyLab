variable "cidr_block" {
    type = list(string)
    default = [ "172.20.0.0/16","172.20.10.0/24" ] //cidr vpc and cidr subnet
  
}
variable "ports" {
 type = list(number)
 default = [22,80,443,8080,8081]
}
variable "ami" {
  type = string
  default = "ami-0f9ce67dcf718d332"
  
}
variable "instance_type" {
  type = string
  default = "t2.micro"
  
}

variable "key_name" {
  type = string
  default = "devops-nicolas"
  
}
variable "tag_name" {
  type = string
  default = "Jenkins-server"
  
}
variable "anstag_name" {
  type = string
  default = "AnsibleCN"
  
}
    
variable "ansManatag_name" {
  type = string
  default = "AnsibleMN-ApacheTomcat"
  
}
variable "dockertag_name" {
  type = string
  default = "AnsibleMN-DockerHost"
  
}
variable "Nexustag" {
  type = string
  default = "Nexus-server"
  
}
variable "instance_type_nexus" {
  type = string
  default = "t2.medium"
  
}