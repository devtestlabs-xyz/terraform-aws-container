# https://www.terraform.io/docs/providers/aws/index.html
provider "aws" {
  version = "~> 2.42.0"  
}

# https://www.terraform.io/docs/providers/consul/index.html
provider "consul" {
  version = "~> 2.6.1"
}

# https://www.terraform.io/docs/providers/template/index.html
provider "template" {
  version = "~> 2.1.2"
}

# https://www.terraform.io/docs/providers/random/index.html
provider "random" {
  version = "~> 2.2.1"
}

# https://www.terraform.io/docs/providers/null/index.html
provider "null" {
  version = "~> 2.1.2"
}
