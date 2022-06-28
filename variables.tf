variable "role_arn" {
}

variable "subnet_ids" {
}

variable "security_group_ids" {
}

variable "node_groups" {
}

variable "node_group_names" {
}

variable "node_role_arn" {
}

variable "security_groups_rules" {
    default = [
        {
          name : "https ingress"
          cidr_block : ["0.0.0.0/0"]
          description : "for communication"
          from_port : 443
          to_port : 443
          type : "ingress"
          protocol : "tcp"
        },
        {
          name : "http ingress"
          cidr_block : ["0.0.0.0/0"]
          description : "for communication"
          from_port : 80
          to_port : 80
          type : "ingress"
          protocol : "tcp"
        },
        {
          name : "Redis ingress"
          cidr_block : ["0.0.0.0/0"]
          description : "for communication"
          from_port : 6379
          to_port : 6379
          type : "ingress"
          protocol : "tcp"
        },
        {
          name : "Redis ingress"
          cidr_block : ["0.0.0.0/0"]
          description : "for communication"
          from_port : 16379
          to_port : 16379
          type : "ingress"
          protocol : "tcp"
        }
    ]
}

variable "tags" {
}