# terraform-aws-container
This project manages the assets required to build and publish an extremely lightweight [Hashicorp Terraform](https://www.terraform.io/) [OCI compliant](https://www.opencontainers.org/) container image that runs on [Docker](https://www.docker.com/), [Podman](https://podman.io/), and [Kubernetes](https://kubernetes.io/). This Terraform container is purpose-built to provision and manage AWS resources.


# Run Docker container
## Pre-Flight
Ensure the follow prerequisites are satisfied:

* Valid, active AWS IAM user exists
* Docker image is locally avaiable or can be pulled from a container repository such as DockerHub, ACR, etc
* `.env` file with applicable environment variable definitions or environment variables passed to Docker via the CLI
* Terraform `*.tf` configuration file is in $PWD

```
docker run \
--rm -it \
-v $(pwd)/live:/terraform-live \
--env-file=.env.local \
devtestlabs/terraform-aws init
```

```
docker run \
--rm -it \
-v $(pwd):/terraform-live \
-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
-e AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} \
devtestlabs/terraform-aws init
```

# Test container
## Verify Terraform finds and initializes all installed Provider plugins
Create `live` directory.

Create `providers-test.tf `file with the following contents:

```
# All providers installed in this container
provider "aws" {
  version = "~> 2.42.0"  
}

provider "consul" {
  version = "~> 2.6.1"
}

provider "template" {
  version = "~> 2.1.2"
}

provider "random" {
  version = "~> 2.2.1"
}

provider "null" {
  version = "~> 2.1.2"
}
```

In project root path, execute:
```
docker run \
--rm -it \
-v $(pwd)/live:/terraform \
devtestlabs/terraform-aws init
```

## Verify connectivity to AWS
Create `.env` Docker environment variables file with the following contents:

```
AWS_ACCESS_KEY_ID={{ YOUR_ACCESS_KEY_ID }}
AWS_SECRET_ACCESS_KEY={{ YOUR_SECRET_ACCESS_KEY }}
AWS_DEFAULT_REGION={{ YOUR_AWS_DEFAULT_REGION }}
```

*NOTE: Replace {{ YOUR_*** }} with a valid value. If you don't want to persist secrets to file, you can also set host environment variables and reference these environment variables in your `.env` file (example: `AWS_ACCESS_KEY_ID=$MY_AWS_ACCESS_KEY_ID` where `$MY_AWS_ACCESS_KEY_ID` is the host environment variable).*

Execute:
```
docker run \
--rm -it \
-v $(pwd)/live/:/terraform-live \
--env-file=.env.local \
devtestlabs/terraform-aws init
```

*example*
```
docker run \
--rm -it \
-v $(pwd)/live:/terraform-live \
--env-file=.env.local \
devtestlabs/terraform-aws init
```

# Build Docker image locally
## Pre-Flight
* Docker or Podman should be installed on your workstation.
* Clone this GitHub project.

## Build the image
* `cd` into the project root path.

```
docker build -t terraform-aws .
```

# External References
* https://www.terraform.io/docs/configuration/providers.html
* https://www.terraform.io/docs/providers/consul/index.html
* https://www.terraform.io/docs/providers/aws/index.html
* https://github.com/hashicorp/terraform/blob/master/scripts/docker-release/Dockerfile-release
* https://github.com/terraform-providers/terraform-provider-aws
* https://releases.hashicorp.com/terraform-provider-aws/
* https://github.com/terraform-providers/terraform-provider-consul
* https://releases.hashicorp.com/terraform-provider-consul/
* https://releases.hashicorp.com/terraform-provider-template/
* https://releases.hashicorp.com/terraform-provider-null/
* https://releases.hashicorp.com/terraform-provider-random/

