# Terraform for AWS resource provisioning and management
This image an extremely lightweight [Hashicorp Terraform](https://www.terraform.io/) [OCI compliant](https://www.opencontainers.org/) container image that runs on [Docker](https://www.docker.com/) and [Podman](https://podman.io/). This Terraform container is purpose-built to provision and manage AWS resources.

The base image is the [official Hashicorp Terraform image](https://hub.docker.com/r/hashicorp/terraform/) which is based on the [official Alpine Linux image](https://hub.docker.com/_/alpine).

## Latest container image
### Tags
* 0.12.29-aws-14138182 ({{  TERRAFORM_VERSION }}-{{ IMAGE_VARIANT }}-{{ GITHUB_8BIT_COMMIT_HASH }})
* 0.12.29-aws-20200731T230752Z ({{  TERRAFORM_VERSION }}-{{ IMAGE_VARIANT }}-{{ DATETIME_%Y%m%dT%H%M%SZ }})
* aws

*NOTE: For production environments always pin a long version.*

The latest version of the container image configuration includes:

* Terraform version 0.12.29

The following pinned versions of providers are installed and initialized:
* AWS_PROVIDER_VERSION=3.0.0
* CONSUL_PROVIDER_VERSION=2.9.0
* TEMPLATE_PROVIDER_VERSION=2.1.2
* NULL_PROVIDER_VERSION=2.1.2
* RANDOM_PROVIDER_VERSION=2.3.0

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
devtestlabs/terraform:aws init
```

```
docker run \
--rm -it \
-v $(pwd):/terraform-live \
-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
-e AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} \
devtestlabs/terraform:aws init
```

# Test container
## Verify Terraform finds all expected providers

In project root path, execute:

*Docker*
```shell
docker run \
--rm -it \
-v $(pwd)/live:/terraform-live \
devtestlabs/terraform:aws init
```

*Podman*
```shell
podman run -it -v $(pwd)/live:/terraform devtestlabs/terraform:aws init
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

*Docker*
```shell
docker run \
--rm -it \
-v $(pwd)/test/:/terraform-live \
--env-file=.env.local \
devtestlabs/terraform-aws init
```

*Docker example*
```shell
docker run \
--rm -it \
-v $(pwd)/test:/terraform-live \
--env-file=.env.local \
devtestlabs/terraform-aws init
```

*Podman example*
```shell
podman run -it -v $(pwd)/test:/terraform-live:Z --env-file=.env.local devtestlabs/terraform:aws init
```
# Github project

https://github.com/devtestlabs-xyz/terraform-aws-container