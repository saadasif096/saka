terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>3.5.0"
            
        }
    }
}
provider "aws" {
    access_key = "AKIAQFLAZFO7TL7NYCCQ"
 secret_key = "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"
    region = "us-east-1"
}