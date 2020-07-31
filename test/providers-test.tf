# All providers should be onboard and initialized in this container
# https://www.terraform.io/docs/providers/aws/index.html
provider "aws" {
  version = "~> 3.0.0"  
}

# https://www.terraform.io/docs/providers/consul/index.html
provider "consul" {
  version = "~> 2.9.0"
}

# https://www.terraform.io/docs/providers/template/index.html
provider "template" {
  version = "~> 2.1.2"
}

# https://www.terraform.io/docs/providers/random/index.html
provider "random" {
  version = "~> 2.3.0"
}

# https://www.terraform.io/docs/providers/null/index.html
provider "null" {
  version = "~> 2.1.2"
}