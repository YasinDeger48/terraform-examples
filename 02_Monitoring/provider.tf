# Terraform versiyonu belirtiliyor
terraform {
  required_version = ">= 1.0.0"
  
  # Gerekli provider'lar tanımlanıyor
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Provider yapılandırması
provider "aws" {
  region  = "us-east-1"          # AWS Region (Örn: eu-central-1)
  profile = "default"               # AWS CLI Profile adı (AWS CLI üzerinden login yapıldıysa)
  
  # Aşağıdaki iki satırı ekleyerek access ve secret key ile erişim yapabilirsiniz
   access_key = ""  # AWS Access Key ID
   secret_key = ""  # AWS Secret Access Key
}
