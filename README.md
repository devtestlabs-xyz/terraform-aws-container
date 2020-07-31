# terraform-aws-container
This project manages the assets required to build and publish an extremely lightweight [Hashicorp Terraform](https://www.terraform.io/) [OCI compliant](https://www.opencontainers.org/) container image that runs on [Docker](https://www.docker.com/) and [Podman](https://podman.io/). This Terraform container is purpose-built to provision and manage AWS resources.


# Run Docker container
## Pre-Flight
Ensure the follow prerequisites are satisfied:

* Valid, active AWS IAM user exists
* Docker image is locally avaiable or can be pulled from a container repository such as DockerHub, ACR, etc
* `.env` file with applicable environment variable definitions or environment variables passed to Docker via the CLI *NOTE: You can copy the `.env.example` file and change the environment variable values to valid values. `.gitignore` entries are in place to help protect you from committing your `.env.* file. DO NOT commit secrets to your repo!*
* Terraform `providers-init.tf` configuration file is in `$PWD/dockerfiles`

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
## Verify Terraform finds all expected providers

In project root path, execute:

```shell
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

```shell
docker run \
--rm -it \
-v $(pwd)/live/:/terraform-live \
--env-file=.env.local \
devtestlabs/terraform-aws init
```

*example*
```shell
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
* `cd` into the `./dockerfiles`

*Docker*
```shell
docker build -t terraform-aws .
```

*Podman*
```shell
podman build -t terraform-aws .
```

# Dockerhub repository
Container images are automatically published to `devtestlabs/terraform` Dockerhub repository.

https://hub.docker.com/r/devtestlabs/terraform


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

