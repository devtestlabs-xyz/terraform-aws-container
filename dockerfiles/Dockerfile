# Official Hashicorp Terraform Docker image
# https://hub.docker.com/r/hashicorp/terraform/tags
# latest = latest light image
# source dockerfile https://github.com/hashicorp/terraform/blob/master/scripts/docker-release/Dockerfile-release
ARG BASE_IMAGE_VERSION
FROM hashicorp/terraform:${BASE_IMAGE_VERSION}

# Pass in value from GH Actions
ARG AWS_PROVIDER_VERSION
ARG CONSUL_PROVIDER_VERSION
ARG TEMPLATE_PROVIDER_VERSION
ARG NULL_PROVIDER_VERSION
ARG RANDOM_PROVIDER_VERSION

ARG IMAGE_BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG IMAGE_LONG_VERSION

# Required to build Docker image; removed in cleanup process
ENV APK_VIRTUAL_PACKAGE_DEPS \
  git \
  openssh \
  gnupg \
  wget

# Terraform environment variables
ENV TF_PLUGIN_CACHE_DIR=/.terraform/plugin-cache

COPY providers-init.tf .

RUN set -x \
    && \
    echo "==> Installing required APK packages..." \
    && apk add --no-cache --virtual .build-deps ${APK_VIRTUAL_PACKAGE_DEPS} \
    && \
    echo "==> Creating Terraform shared plugin cache path..." \
    && mkdir -p /.terraform/plugin-cache \
    && \
    echo "==> Fetching Hashicorp PGP Public Key..." \
    && wget https://raw.githubusercontent.com/hashicorp/terraform/master/scripts/docker-release/releases_public_key \
    && gpg --import releases_public_key \
    && \
    echo "==> Fetching AWS provider plugin..." \
    && wget https://releases.hashicorp.com/terraform-provider-aws/${AWS_PROVIDER_VERSION}/terraform-provider-aws_${AWS_PROVIDER_VERSION}_SHA256SUMS \
    && wget https://releases.hashicorp.com/terraform-provider-aws/${AWS_PROVIDER_VERSION}/terraform-provider-aws_${AWS_PROVIDER_VERSION}_SHA256SUMS.sig \
    && wget https://releases.hashicorp.com/terraform-provider-aws/${AWS_PROVIDER_VERSION}/terraform-provider-aws_${AWS_PROVIDER_VERSION}_linux_amd64.zip \
    && \
    echo "==> Verifying Hashicorp signature and binary checksums..." \
    && gpg --verify terraform-provider-aws_${AWS_PROVIDER_VERSION}_SHA256SUMS.sig terraform-provider-aws_${AWS_PROVIDER_VERSION}_SHA256SUMS \
    && grep linux_amd64 terraform-provider-aws_${AWS_PROVIDER_VERSION}_SHA256SUMS >terraform-provider-aws_${AWS_PROVIDER_VERSION}_SHA256SUMS_linux_amd64 \
    && sha256sum -cs terraform-provider-aws_${AWS_PROVIDER_VERSION}_SHA256SUMS_linux_amd64 \
    && \
    echo "==> Installing AWS provider..." \
    && unzip terraform-provider-aws_${AWS_PROVIDER_VERSION}_linux_amd64.zip -d /bin \
    && \
    echo "==> Fetching Consul provider plugin..." \
    && wget https://releases.hashicorp.com/terraform-provider-consul/${CONSUL_PROVIDER_VERSION}/terraform-provider-consul_${CONSUL_PROVIDER_VERSION}_SHA256SUMS \
    && wget https://releases.hashicorp.com/terraform-provider-consul/${CONSUL_PROVIDER_VERSION}/terraform-provider-consul_${CONSUL_PROVIDER_VERSION}_SHA256SUMS.sig \
    && wget https://releases.hashicorp.com/terraform-provider-consul/${CONSUL_PROVIDER_VERSION}/terraform-provider-consul_${CONSUL_PROVIDER_VERSION}_linux_amd64.zip \
    && \
    echo "==> Verifying Hashicorp signature and binary checksums..." \
    && gpg --verify terraform-provider-consul_${CONSUL_PROVIDER_VERSION}_SHA256SUMS.sig terraform-provider-consul_${CONSUL_PROVIDER_VERSION}_SHA256SUMS \
    && grep linux_amd64 terraform-provider-consul_${CONSUL_PROVIDER_VERSION}_SHA256SUMS >terraform-provider-consul_${CONSUL_PROVIDER_VERSION}_SHA256SUMS_linux_amd64 \
    && sha256sum -cs terraform-provider-consul_${CONSUL_PROVIDER_VERSION}_SHA256SUMS_linux_amd64 \
    && \
    echo "==> Installing Consul provider..." \
    && unzip terraform-provider-consul_${CONSUL_PROVIDER_VERSION}_linux_amd64.zip -d /bin \
    && \
    echo "==> Fetching Template provider plugin..." \
    && wget https://releases.hashicorp.com/terraform-provider-template/${TEMPLATE_PROVIDER_VERSION}/terraform-provider-template_${TEMPLATE_PROVIDER_VERSION}_SHA256SUMS \
    && wget https://releases.hashicorp.com/terraform-provider-template/${TEMPLATE_PROVIDER_VERSION}/terraform-provider-template_${TEMPLATE_PROVIDER_VERSION}_SHA256SUMS.sig \
    && wget https://releases.hashicorp.com/terraform-provider-template/${TEMPLATE_PROVIDER_VERSION}/terraform-provider-template_${TEMPLATE_PROVIDER_VERSION}_linux_amd64.zip \
    && \
    echo "==> Verifying Hashicorp signature and binary checksums..." \
    && gpg --verify terraform-provider-template_${TEMPLATE_PROVIDER_VERSION}_SHA256SUMS.sig terraform-provider-template_${TEMPLATE_PROVIDER_VERSION}_SHA256SUMS \
    && grep linux_amd64 terraform-provider-template_${TEMPLATE_PROVIDER_VERSION}_SHA256SUMS >terraform-provider-template_${TEMPLATE_PROVIDER_VERSION}_SHA256SUMS_linux_amd64 \
    && sha256sum -cs terraform-provider-template_${TEMPLATE_PROVIDER_VERSION}_SHA256SUMS_linux_amd64 \
    && \
    echo "==> Installing Template provider..." \
    && unzip terraform-provider-template_${TEMPLATE_PROVIDER_VERSION}_linux_amd64.zip -d /bin \
    && \
    echo "==> Fetching Random provider plugin..." \
    && wget https://releases.hashicorp.com/terraform-provider-random/${RANDOM_PROVIDER_VERSION}/terraform-provider-random_${RANDOM_PROVIDER_VERSION}_SHA256SUMS \
    && wget https://releases.hashicorp.com/terraform-provider-random/${RANDOM_PROVIDER_VERSION}/terraform-provider-random_${RANDOM_PROVIDER_VERSION}_SHA256SUMS.sig \
    && wget https://releases.hashicorp.com/terraform-provider-random/${RANDOM_PROVIDER_VERSION}/terraform-provider-random_${RANDOM_PROVIDER_VERSION}_linux_amd64.zip \
    && \
    echo "==> Verifying Hashicorp signature and binary checksums..." \
    && gpg --verify terraform-provider-random_${RANDOM_PROVIDER_VERSION}_SHA256SUMS.sig terraform-provider-random_${RANDOM_PROVIDER_VERSION}_SHA256SUMS \
    && grep linux_amd64 terraform-provider-random_${RANDOM_PROVIDER_VERSION}_SHA256SUMS >terraform-provider-random_${RANDOM_PROVIDER_VERSION}_SHA256SUMS_linux_amd64 \
    && sha256sum -cs terraform-provider-random_${RANDOM_PROVIDER_VERSION}_SHA256SUMS_linux_amd64 \
    && \
    echo "==> Installing Random provider..." \
    && unzip terraform-provider-random_${RANDOM_PROVIDER_VERSION}_linux_amd64.zip -d /bin \
    && \
    echo "==> Fetching Null provider plugin..." \
    && wget https://releases.hashicorp.com/terraform-provider-null/${NULL_PROVIDER_VERSION}/terraform-provider-null_${NULL_PROVIDER_VERSION}_SHA256SUMS \
    && wget https://releases.hashicorp.com/terraform-provider-null/${NULL_PROVIDER_VERSION}/terraform-provider-null_${NULL_PROVIDER_VERSION}_SHA256SUMS.sig \
    && wget https://releases.hashicorp.com/terraform-provider-null/${NULL_PROVIDER_VERSION}/terraform-provider-null_${NULL_PROVIDER_VERSION}_linux_amd64.zip \
    && \
    echo "==> Verifying Hashicorp signature and binary checksums..." \
    && gpg --verify terraform-provider-null_${NULL_PROVIDER_VERSION}_SHA256SUMS.sig terraform-provider-null_${NULL_PROVIDER_VERSION}_SHA256SUMS \
    && grep linux_amd64 terraform-provider-null_${NULL_PROVIDER_VERSION}_SHA256SUMS >terraform-provider-null_${NULL_PROVIDER_VERSION}_SHA256SUMS_linux_amd64 \
    && sha256sum -cs terraform-provider-null_${NULL_PROVIDER_VERSION}_SHA256SUMS_linux_amd64 \
    && \
    echo "==> Installing Null provider..." \
    && unzip terraform-provider-null_${NULL_PROVIDER_VERSION}_linux_amd64.zip -d /bin \
    && \
    echo "==> Cleaning up..." \
    && apk del .build-deps \
    && rm -f terraform-provider-aws_${AWS_PROVIDER_VERSION}_linux_amd64.zip terraform-provider-aws_${AWS_PROVIDER_VERSION}_SHA256SUMS terraform-provider-aws_${AWS_PROVIDER_VERSION}_SHA256SUMS.sig \
    && rm -f terraform-provider-consul_${CONSUL_PROVIDER_VERSION}_linux_amd64.zip terraform-provider-consul_${CONSUL_PROVIDER_VERSION}_SHA256SUMS terraform-provider-consul_${CONSUL_PROVIDER_VERSION}_SHA256SUMS.sig \
    && rm -f terraform-provider-template_${TEMPLATE_PROVIDER_VERSION}_linux_amd64.zip terraform-provider-template_${TEMPLATE_PROVIDER_VERSION}_SHA256SUMS terraform-provider-template_${TEMPLATE_PROVIDER_VERSION}_SHA256SUMS.sig \
    && rm -f terraform-provider-random_${RANDOM_PROVIDER_VERSION}_linux_amd64.zip terraform-provider-random_${RANDOM_PROVIDER_VERSION}_SHA256SUMS terraform-provider-random_${RANDOM_PROVIDER_VERSION}_SHA256SUMS.sig \
    && rm -f terraform-provider-null_${NULL_PROVIDER_VERSION}_linux_amd64.zip terraform-provider-null_${NULL_PROVIDER_VERSION}_SHA256SUMS terraform-provider-null_${NULL_PROVIDER_VERSION}_SHA256SUMS.sig \
    && rm -f releases_public_key \
    && \
    echo "==> Initializing installed Terraform providers..." \
    && terraform init

# /terraform will contain all terraform assets including mounted live configurations
# WORKDIR /terraform-live

# VOLUME [ "/terraform-live" ]

# Credentials
ENV AWS_ACCESS_KEY_ID=UNDEFINED
ENV AWS_SECRET_ACCESS_KEY=UNDEFINED
ENV AWS_DEFAULT_REGION=UNDEFINED

# Shared credentials file
##ENV AWS_SHARED_CREDENTIALS_FILE=UNDEFINED

# EC2 Role
##ENV AWS_METADATA_URL=UNDEFINED
##ENV AWS_METADATA_TIMEOUT=UNDEFINED

# ECS and CodeBuild Task Roles
##ENV AWS_CONTAINER_CREDENTIALS_RELATIVE_URI=UNDEFINED

ENTRYPOINT [ "terraform" ]
CMD "$@"

# Labels
LABEL maintainer="Ryan Craig"

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$IMAGE_BUILD_DATE
LABEL org.label-schema.name="devtestlabs/terraform"
LABEL org.label-schema.description="Hashicorp Terraform for AWS resource provisioning and management"
#LABEL org.label-schema.url=$ORG_WEB_URL
LABEL org.label-schema.vcs-url=$VCS_URL
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vendor="devtestlabs.xyz"
LABEL org.label-schema.version=$IMAGE_LONG_VERSION