FROM ubuntu:22.04

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

# Create and set the working directory
WORKDIR /workspace

# Install necessary packages and dependencies for Yocto builds.
# This includes all the recommended packages listed in the Yocto Project Quick Start
# guide for a Ubuntu-based host, plus packages listed in TI Documentation.
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y  \
	apt-transport-https bash bison build-essential ca-certificates chrpath cpio curl \
	debianutils diffstat dos2unix doxygen file flex gawk gcc git git-lfs g++-multilib \
	icecc iputils-ping jq libacl1 libc6-dev-i386 libegl1-mesa liblz4-tool \
	libsdl1.2-dev libssl-dev locales locales lz4 mesa-common-dev mono-complete \
	mono-devel patchelf pigz pseudo python3 python3-distutils python3-git \
	python3-jinja2 python3-pexpect python3-pip python3-sphinx python3-subunit repo \
	socat sudo texinfo tree u-boot-tools unzip wget xz-utils zstd

RUN locale-gen en_US.UTF-8

RUN update-ca-certificates

# Set environment variables
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Arguments to pass host user's UID and GID
ARG USER_ID=1000
ARG GROUP_ID=1000

# Create a user 'developer' with the same UID/GID as the host user
RUN groupadd -g ${GROUP_ID} developer
RUN useradd -m -u ${USER_ID} -g developer -d /home/developer developer
RUN mkdir -p /workspace
RUN chown -R developer:developer /workspace
RUN mkdir -p /home/developer/.ssh
RUN touch /home/developer/.ssh/known_hosts
RUN chmod 700 /home/developer/.ssh
RUN chmod 600 /home/developer/.ssh/known_hosts
RUN chown -R developer:developer /home/developer/.ssh

RUN git config --add --system user.email "developer@example.com"
RUN git config --add --system user.name "Build Container"
RUN git config --add --system http.version HTTP/1.1

# The entry point is set to bash. This means that when the container starts, it will drop the user into bash
ENTRYPOINT ["/bin/bash"]
